# PersonalKnowledge OS 使用手册

> 更新时间：2026-05-10
> 系统版本：v1.0

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

## 五、会话存档体系（独立）

```
~/.hermes-archive/           ← 热备（不在 Git）
├── hermes/sessions/         ← 有意义 session 原始文件
├── hermes/cron-logs/        ← cron 结构化日志（jsonl）
└── openclaw/sessions/       ← openclaw sessions

Hindsight PostgreSQL           ← 向量检索，Agent 实时查询

GitHub: sessions-backup      ← 冷备仓库
```

### 过滤策略

| 类型 | 处理 |
|------|------|
| "你好" 类寒暄 | 跳过，不存档 |
| cron 任务 | 转结构化 .jsonl log |
| 有实质工具调用 | 正常存档到 Hindsight + 热备 |

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
