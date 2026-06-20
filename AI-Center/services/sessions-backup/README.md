# Sessions Backup 系统

> AI Agent 会话存档备份体系。独立于 Agent 原始目录，按"热备 → 冷备 → Hindsight 向量库"三层架构运行。
>
> 更新记录：[sessions-backup](./CHANGELOG.md)

---

## 架构概览

```
原始会话目录
├── ~/.hermes/sessions/          ← Hermes live sessions（9个）
│   └── 20260416_*.jsonl
│   └── 20260509_*.jsonl
└── ~/.openclaw/.../sessions/    ← OpenClaw live sessions（43个）
    └── *.jsonl

        ↓ 每小时 [session-backup.py]

热备目录 /home/shin/sessions/
├── hermes/
│   └── 2026-05-10/             ← 按日期分目录
│       └── 20260416_*.jsonl
│       └── 20260509_*.jsonl
├── openclaw/
│   └── 2026-05-10/
│       └── *.jsonl
├── manifest.json                 ← 索引（哪些文件已备份）
└── hindsight_imported.json     ← 导入记录（增量去重）

        ↓ 每小时 [session-backup.py]（含 Hindsight 入库）

Hindsight 向量库 (PostgreSQL)
└── Bank: Hermes
    └── memory_units（向量检索）

        ↓ 每小时 [sessions-git-backup.sh]
```

---

## 目录结构

```
/home/shin/sessions/
├── hermes/                 ← 按 Agent 分组
│   └── YYYY-MM-DD/        ← 按日期分组
│       └── *.jsonl
├── openclaw/
│   └── YYYY-MM-DD/
│       └── *.jsonl
├── manifest.json            ← 备份索引（Git 追踪）
├── hindsight_imported.json ← Hindsight 导入记录
└── heartbeat.log           ← 自动化心跳会话记录
```

---

## 服务详情

### 热备目录

| 属性 | 值 |
|------|-----|
| **路径** | `/home/shin/sessions/` |
| **Git 仓库** | `sessions-backup` (GitHub) |
| **所有者** | shin |

### 备份脚本

| 脚本 | 功能 | 触发 |
|------|------|------|
| `session-backup.py` | 增量备份 + Hindsight 入库 | 每小时 |
| `sessions-git-backup.sh` | 打包推送 GitHub | 每小时 |

---

## 备份策略

### 增量备份逻辑

1. **热备**：manifest 记录已备份文件，重复跳过，不重复复制
2. **Git 冷备**：manifest 变更 → 打包新 tarball → commit → push
3. **Hindsight**：hindsight_imported.json 记录已导入 session_id，增量去重

### 心跳识别

自动化任务（cron）会话不进入 Hindsight，写入 `heartbeat.log`：

```python
# Hermes: "platform": "cron" 字段
if '"platform"' in content and '"cron"' in content:
    return True

# OpenClaw: 短小 + 无工具调用
if len(content) < 1000 and 'terminal' not in content:
    return True
```

---

## 文件清单

### 脚本

| 文件 | 路径 |
|------|------|
| 热备脚本（含 Hindsight 入库） | `/home/shin/bin/session-backup.py` |
| Git 冷备脚本 | `/home/shin/bin/sessions-git-backup.sh` |

### Cron 任务

```cron
# 热备 + Hindsight 入库 - 每小时
0 * * * * python3 /home/shin/bin/session-backup.py >> /home/shin/logs/session-backup.log 2>&1

# Git 冷备 - 每小时
30 * * * * bash /home/shin/bin/sessions-git-backup.sh >> /home/shin/logs/sessions-git-backup.log 2>&1
```

---

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | cron 任务、`/home/shin/sessions/`、`session-backup.py` 日志 | 备份链路本体 |
| 检查命令 | `crontab -l | grep -E 'session-backup|sessions-git-backup'`；`tail -n 50 /home/shin/logs/session-backup.log` | cron + 日志 |
| 判据 | cron 条目存在、日志持续更新、manifest 有增量 | 任务正常运行 |
| 频率 | 每小时任务后 / 每日巡检 / 改脚本后 | 例行 + 变更 |
| 失败动作 | 补 cron、查日志、手动重跑脚本 | 先恢复链路 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/.hermes/sessions/`、`~/.openclaw/.../sessions/`、`/home/shin/sessions/`、GitHub `sessions-backup` | 原始会话与热/冷备 |
| 备份方式 | 热备增量复制 + Git 冷备 + Hindsight 入库 | 三层架构 |
| 频率 | 每小时 | 固定节奏 |
| 保留策略 | 热备按日期分目录，Git 追踪版本，Hindsight 去重入库 | 分层保留 |
| 恢复命令 | 从热备 / Git 冷备恢复后，重新跑归档脚本与 Hindsight 入库 | 先恢复再入库 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | cron 缺失、日志报错、manifest/导入记录不更新 | 任一即异常 |
| 通知渠道 | 当前未接自动告警；先人工巡检 | 现状如实写 |
| 兜底动作 | 手动触发 `session-backup.py` / `sessions-git-backup.sh` | 先恢复备份链路 |
| 升级路径 | 先恢复链路，再查 Hindsight 与 Git 同步 | 不跳步 |

### 恢复 / 回滚

- 热备优先恢复，冷备用于兜底
- 恢复后要重新跑一次入库链路，确保 Hindsight 同步

## 迭代记录

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| v1.0 | 2026-05-10 | 初始文档 |
| v1.1 | 2026-05-11 | Hindsight 入库从每日批量改为嵌入 session-backup.py，每小时增量处理 |

---

## 相关文档

- [Hindsight](../../services/hindsight/README.md) — 向量记忆库
- [Hermes](../../services/hermes/README.md) — 主 Agent
- [OpenClaw](../../platforms/openclaw/README.md) — 执行层 Agent
- [AI-Center-拓扑图](../../docs/AI-Center-拓扑图.md) — 系统全拓扑
