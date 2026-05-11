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

## 版本记录

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
