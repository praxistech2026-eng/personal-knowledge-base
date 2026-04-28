# Hermes Knowledge OS 使用手册

> 更新时间：2026-04-28
> 系统版本：v1（原型）

---

## 一、系统定位

这不是普通的笔记软件。这是一个**会进化的知识操作系统**。

核心能力：
- 自然语言输入 → 结构化知识卡片
- 自动识别「同一概念」，避免重复创建
- 知识的增量更新与演化（不是堆砌，而是迭代）
- 多 Agent 会话自动归档，跨会话知识追踪

**最终目标**：在任何 Agent 会话中讨论过的知识，都能沉淀到一套统一的知识库，并在后续会话中被调用。

---

## 二、目录结构

```
HermesKnowledge/
├── AgentSessions/           ← [新增] Agent 会话原始存档
│   ├── hermes/sessions/     ←   Hermes Agent 会话
│   ├── openclaw/sessions/   ←   OpenClaw 会话
│   └── claude-code/sessions/←   Claude Code 会话
│
├── Knowledge/               ← 核心知识库
│   ├── AI/                  ← AI/ML 相关概念
│   ├── Business/            ← 商业/创业相关
│   ├── Personal/            ← 个人相关
│   ├── Misc/                ← 杂项
│   ├── Inbox/               ← 临时输入（待整理）
│   ├── MergeQueue/          ← 合并候选区（重要！）
│   ├── Archive/             ← 历史版本备份（只增不减）
│   └── Review/              ← 待回顾内容
│
├── Templates/
│   └── Knowledge.md         ← 知识卡片模板
│
└── README.md                ← 系统说明
```

---

## 三、核心概念

### 3.1 知识卡片格式

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

### 3.2 最重要的规则：文件名 = Canonical Concept

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
Transformer模型.md ❌
Transformer架构详解.md ❌
```

**为什么？** 文件名是知识的唯一标识。`Transformer.md` 里面包含了 Transformer 的所有知识。如果你在另一个会话里又创建了 `Transformer架构.md`，知识就分裂了，系统就乱了。

### 3.3 Canonical Concept 必须归一

归一 = 找到最底层、不可分割的概念名。

```
Transformer 架构 → Transformer（架构只是修饰）
Transformer 编码器 → Transformer（编码器不是独立的）
自注意力 → Attention机制（如果已有这个）
位置编码 → 位置编码（已经是底层）
```

---

## 四、当前状态：hn/ha 命令尚未实现

> ⚠️ 重要说明

README 中描述了 `hn`（新建知识）和 `ha`（应用合并）两个命令，但**这两个命令目前尚未实现**。

当前的知识库是通过手动创建文件建立的。

**已有的知识卡片（共8张）：**

AI 类：
- `Knowledge/AI/Transformer.md`
- `Knowledge/AI/Attention机制.md`
- `Knowledge/AI/位置编码.md`
- `Knowledge/AI/Layer Normalization.md`
- `Knowledge/AI/Mixture of Experts.md`

Business 类：
- `Knowledge/Business/如何设计一个商业模式.md`

待处理：
- `Knowledge/MergeQueue/Transformer_merge_20260420_010423.md` ← 待你审核后合并
- `Knowledge/Archive/Transformer_backup_20260419_234153.md` ← Transformer 的旧版本备份

---

## 五、工作流程（当前手动版）

### 5.1 新建知识

**步骤 1**：确定 Canonical Concept 名

先想清楚：这个知识要归到哪个概念名下？

**步骤 2**：判断是新建还是更新

- 这个概念 Knowledge/ 下完全没有 → 新建文件
- 这个概念已经存在（如 `Transformer.md`）→ 不要新建，要更新现有文件

**步骤 3**：按模板格式写入文件

```bash
# 打开文件（新建或编辑）
nvim ~/HermesKnowledge/Knowledge/AI/Transformer.md
```

### 5.2 更新已有知识（MergeQueue 机制）

当你认为某次会话对某个已有概念有了更深入的理解：

**不要直接覆盖原文件**，而是：

1. 把更新内容写入 `MergeQueue/` 目录，文件名格式：
   ```
   MergeQueue/Transformer_merge_YYYYMMDD_HHMMSS.md
   ```

2. 内容包含：
   - 原始文件内容
   - 新增/修改的部分（用不同颜色或 `---UPDATE---` 分隔）
   - 说明这次更新了什么

3. 你在 Obsidian 中打开 MergeQueue，审核后：
   - 确认没问题 → 用更新版本替换原文件
   - 同时旧版本自动备份到 Archive

### 5.3 审核 MergeQueue

查看 `Knowledge/MergeQueue/` 目录，对每条候选合并：

1. 读取代合并内容
2. 判断：更新是否值得合并？
3. 如果值得 → 手动替换原文件，旧版自动进 Archive
4. 如果不值得 → 删除候选稿，原文件不变

---

## 六、会话归档系统（已实现）

### 6.1 自动归档

每小时自动运行一次归档脚本：

```bash
python3 ~/.hermes/scripts/archive-sessions.py
```

**归档内容：**
- Hermes Agent 会话（`~/.hermes/sessions/*.jsonl`）
- OpenClaw 会话（`~/.openclaw/agents/main/sessions/*.jsonl`）
- Claude Code 会话（`~/.claude/sessions/*.jsonl`）

**输出位置：**
```
~/HermesKnowledge/AgentSessions/{agent}/sessions/YYYY-MM-DD/{session_id}.md
```

### 6.2 增量更新

同一个 session ID 的会话继续时，新的对话内容会**覆盖更新**原有存档文件（而不是新建），确保一个会话只有一个文件。

### 6.3 GitHub 同步

归档后自动推送到 GitHub（`praxistech2026-eng/hermes-knowledge-base`）。

Mac 端 Obsidian Git 插件会自动 pull，手机端暂不支持。

---

## 七、当前痛点与后续计划

### 已实现
- ✅ 会话自动归档（每h一次）
- ✅ 增量更新机制
- ✅ GitHub 同步
- ✅ 8 张知识卡片

### 待实现
- ❌ `hn` 命令（自然语言 → 知识卡片）
- ❌ `ha` 命令（合并候选 → 更新正式文件）
- ❌ LLM 辅助：从会话中自动提取知识点
- ❌ 跨会话知识追踪（当讨论了已存在的概念时提示）
- ❌ 手机端同步

---

## 八、常见问题

### Q：为什么禁止创建 `Transformer模型.md` 这样的文件？
A：因为它和 `Transformer.md` 是同一个概念。知识库的目的是让「Transformer 的所有知识」集中在一个文件里，而不是分散在多个文件。分散之后，你搜索「Transformer」会得到多个结果，不知道哪个是权威版本。

### Q：MergeQueue 里的文件越来越多怎么办？
A：定期清理。如果候选合并超过 2 周没处理，大概率是不需要合并的，直接删掉。

### Q：Archive 里的备份会一直增加吗？
A：会。这是设计原则——只增不减，用于回滚。不需要手动管理。

### Q：我可以手动在 Knowledge/ 下创建文件吗？
A：可以，但必须遵守命名规则（Canonical Concept）和模板格式。建议先用 Obsidian 打开 vault，确保文件格式正确。

### Q：会话归档后，知识会自动进 Knowledge/ 吗？
A：不会。归档只是存档，不会提取知识。Phase 2 会实现 LLM 辅助的知识提取。

---

## 九、联系方式与协作

当前 session ID（你在看的这个）：`20260428_042056_7a7ac`

如有问题，在任一 Agent 会话中提及「HermesKnowledge」或相关概念，Agent 可以查询这个知识库。

---

*最后更新：2026-04-28*
