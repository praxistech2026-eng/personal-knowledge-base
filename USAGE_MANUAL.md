# HermesKnowledge OS 使用手册

> 更新时间：2026-04-28
> 自动化系统版本：v0.1.1

---

## 一、系统定位

这不是普通的笔记软件。这是一个**会进化的知识操作系统**。

核心能力：
- 自然语言输入 → 结构化知识卡片
- 自动识别「同一概念」，避免重复创建
- 多 Agent 会话自动归档，跨会话知识追踪
- Agent 需要时可查询知识库

**最终目标**：在任何 Agent 会话中讨论过的知识，都能沉淀到统一知识库，并在后续会话中被调用。

---

## 二、目录结构

```
HermesKnowledge/
├── Knowledge/               ← 核心知识库（hn/ha 管理）
│   ├── AI/                 ← AI/ML 相关
│   ├── Business/           ← 商业/创业相关
│   ├── Personal/           ← 个人相关
│   ├── Misc/               ← 杂项
│   ├── Inbox/              ← 临时输入（待整理）
│   ├── MergeQueue/         ← 合并候选区
│   ├── Archive/            ← 历史备份（只增不减）
│   └── Review/             ← 待回顾
│
├── AgentSessions/           ← Agent 会话原始存档（实时同步）
│   └── {agent}/sessions/   ← 按 Agent 分组
│
├── .system/                 ← 自动化系统（SemVer 版本控制）
│   ├── scripts/            ← 同步/发布脚本
│   ├── CHANGELOG.md
│   └── README.md
│
└── README.md               ← 本文件入口
```

---

## 三、知识卡片格式

每一条知识都是一张结构化卡片：

```markdown
# 概念名

## 🧠 Summary
一句话总结这个概念

## 🧩 Primary Concept
一句话的核心定义

## 🔑 Key Points
- 要点1
- 要点2
- 要点3

## 🔗 Relations
- relates_to: [[相关概念A]]
- relates_to: [[相关概念B]]

## 📚 References
- 参考资料

## 🏷 Tags
#标签1 #标签2
```

---

## 四、核心规则：文件名 = Canonical Concept

```
一个概念 = 一个文件 = 一个 Canonical Concept
```

**正确示例：**
```
Transformer.md
Attention机制.md
位置编码.md
```

**错误示例（禁止）：**
```
Transformer模型.md        ❌
Transformer架构详解.md    ❌
```

**原因**：文件名是知识的唯一标识。`Transformer.md` 包含 Transformer 的所有知识。创建重复概念会导致知识分裂。

---

## 五、hn / ha 命令（知识输入与管理）

### 5.1 核心命令

| 命令 | 功能 | 用法 |
|------|------|------|
| `hn` | 新建 / 更新知识 | `hn "你的知识内容"` |
| `ha` | 应用合并 | `ha "概念名_merge_xxx.md"` |

### 5.2 hn 工作流程

```
hn "解释 Transformer"
  → 调用 AI 生成结构化 Markdown
  → 自动分类（AI/Business/Personal/Misc）
  → 判断是否已有该概念
      ├── 没有 → 直接创建正式文件
      └── 有   → 生成合并候选到 MergeQueue/
```

### 5.3 ha 工作流程

```
ha "Transformer_merge_20260420_010423.md"
  → 备份旧版到 Archive/
  → 用合并稿替换正式文件
  → 删除合并候选稿
```

### 5.4 使用示例

```bash
# 新建知识
hn "Transformer 是 Google 2017 年提出的序列建模架构"

# 查看已有知识
ls ~/HermesKnowledge/Knowledge/AI/

# 应用合并
ha "Transformer_merge_20260420_010423.md"
```

---

## 六、会话归档系统

### 6.1 自动归档

每小时自动运行归档脚本：
- Hermes Agent 会话（`~/.hermes/sessions/*.jsonl`）
- OpenClaw 会话（`~/.openclaw/agents/main/sessions/*.jsonl`）
- Claude Code 会话（`~/.claude/sessions/*.jsonl`）

**输出位置：**
```
~/HermesKnowledge/AgentSessions/{agent}/sessions/YYYY-MM-DD/{session_id}.md
```

### 6.2 增量更新

同一 session ID 的会话继续时，新内容会**覆盖更新**原有存档（而不是新建）。

---

## 七、同步机制

### 7.1 自动同步（默认开启）

- 系统每分钟自动检测文件变更
- 有变更即推送到 GitHub
- 无变更时完全静默，不产生 git 噪音

### 7.2 手动同步

```bash
# 立即推送所有变更
hermes-push

# 带自定义消息
hermes-push "更新 Transformer 笔记"
```

### 7.3 Mac 端

Obsidian Git 插件自动同步，无需操作。

---

## 八、版本控制（系统层）

自动化系统（`.system/` 目录）使用 **SemVer** 版本控制。

### 8.1 当前版本

```bash
git describe --tags --abbrev=0
# v0.1.1
```

### 8.2 发布新版本

```bash
# patch（默认）：修复 / 小优化
hermes-release patch

# minor：新功能
hermes-release minor

# major：破坏性变更
hermes-release major
```

### 8.3 SemVer 规范

| 层级 | 场景 |
|------|------|
| **MAJOR** | 不兼容的 API / 工作流变更 |
| **MINOR** | 新增功能（向后兼容） |
| **PATCH** | 修复 / 小优化 |

---

## 九、常见问题

**Q：为什么禁止创建 `Transformer模型.md`？**
A：`Transformer.md` 已经包含了 Transformer 的所有知识。重复创建会导致知识分裂，搜索时得到多个结果。

**Q：MergeQueue 里的文件越来越多怎么办？**
A：超过 2 周没处理的合并候选，大概率不需要合并，直接删掉。

**Q：Archive 里的备份会一直增加吗？**
A：会。只增不减，用于回滚，不需要手动管理。

**Q：会话归档后，知识会自动进 Knowledge/ 吗？**
A：不会。归档只是存档原始对话，不会提取知识。

**Q：笔记在多个设备上会冲突吗？**
A：不会。GitHub 端是唯一真相源，多设备通过 Git 合并。Obsidian Git 插件会处理合并。

---

## 十、更新日志

| 日期 | 版本 | 变更 |
|------|------|------|
| 2026-04-28 | v0.1.1 | 轮询同步（每分钟静默同步），hermes-push-auto |
| 2026-04-28 | v0.1.0 | 初始自动化系统 |

完整变更记录见 `.system/CHANGELOG.md`。

---

*最后更新：2026-04-28*
