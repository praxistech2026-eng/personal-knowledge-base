# PersonalKnowledge OS 使用手册

> 更新时间：2026-05-10
> 系统版本：v1.1

---

## 一、系统定位

个人知识沉淀系统 + AI Center 管理系统。

两个核心职能：
1. **Knowledge/** — 个人沉淀知识，来源包括输入素材、AI 整理、阅读笔记
2. **AI-Center/** — AI Center 完整 WIKI，每个服务独立文档

---

## 二、目录结构

```
PersonalKnowledge/
├── Knowledge/              ← 个人沉淀知识
│   ├── AI/               ← AI 技术知识
│   ├── Business/         ← 商业/创业
│   ├── Personal/         ← 个人
│   ├── Misc/             ← 杂项
│   ├── Inbox/            ← 临时输入（待整理）
│   ├── MergeQueue/       ← 合并候选
│   ├── Archive/          ← 历史备份（只增不减）
│   └── Review/           ← 待回顾
│
├── AI-Center/            ← AI Center WIKI（并级）
│   ├── README.md         ← 总览 + 拓扑图
│   ├── hermes/
│   ├── hindsight/
│   ├── searxng/
│   └── ...（每个服务一个文件夹）
│
├── Templates/            ← Obsidian 模板（可删除）
└── .obsidian/           ← Obsidian 配置
```

---

## 三、知识沉淀工作流

### 输入 → 沉淀

1. 素材进入 `Knowledge/Inbox/`
2. AI 处理后分类到对应目录（AI/Business/Personal/Misc）
3. 整理后的笔记合并到正式目录

### 命名规范：文件名 = Canonical Concept

```
一个概念 = 一个文件
```

**正确：** `Transformer.md`（包含 Transformer 的所有知识）
**错误：** `Transformer模型.md`、`Transformer架构详解.md`（知识分裂）

---

## 四、AI-Center WIKI

每个服务文件夹包含：

| 内容 | 说明 |
|------|------|
| README.md | 功能、配置、生态作用、使用说明、官网/文档 |
| 迭代记录 | 每次变更的日期和操作 |

---

## 五、会话存档体系

### 三层架构

```
原始会话目录
├── ~/.hermes/sessions/          ← Hermes live sessions（9个）
└── ~/.openclaw/.../sessions/    ← OpenClaw live sessions（43个）

    ↓ 每小时 session-backup.py
热备: /home/shin/sessions/         ← hermes/ + openclaw/，按日期分组
    ↓ 每小时 sessions-git-backup.sh
GitHub: praxistech2026-eng/sessions-backup ← 增量 tar.zst 包
    ↓ 每日 sessions-to-hindsight.py
Hindsight PostgreSQL              ← 向量库，Agent 实时检索
```

### 过滤策略

| 类型 | 处理 |
|------|------|
| 自动化心跳（platform: cron） | 写入 `heartbeat.log`，不进 Hindsight |
| 全量存档 | 都进热备 + Git 冷备 |
| 有价值会话 | 进入 Hindsight 向量库 |

### 索引文件

- `manifest.json` — 热备文件索引（Git 追踪）
- `hindsight_imported.json` — Hindsight 导入记录（增量去重）

### 备份脚本

| 脚本 | 功能 | 触发 |
|------|------|------|
| `/home/shin/bin/session-backup.py` | 增量备份到热备目录 | 每小时 |
| `/home/shin/bin/sessions-git-backup.sh` | 打包推送 GitHub | 每小时 |
| `/home/shin/bin/sessions-to-hindsight.py` | 导入 Hindsight 向量库 | 每日 |

---

## 六、同步机制

### 服务端
- 每分钟自动检测变更，推送 GitHub
- Session 归档独立冷备到 `sessions-backup` 仓库

### Mac 端
- Obsidian Git 插件自动 pull/push
- 无需手动操作

---

## 七、常见问题

**Q：Obsidian 里能看到 AI-Center 吗？**
A：能。`AI-Center/` 和 `Knowledge/` 同级，都在 vault 里。

**Q：为什么有两个 Inbox？**
A：历史遗留，已合并到 `Knowledge/Inbox/`。

**Q：MergeQueue 和 Archive 是什么？**
A：历史遗留目录，待后续整理是否保留。
