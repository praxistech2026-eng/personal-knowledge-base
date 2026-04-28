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

## 四、hn/ha 命令已实现

`hn`/`ha` 命令在 2026-04-18 已实现，位于 `~/bin/` 目录。

### 4.1 核心命令

| 命令 | 脚本 | 功能 | 用法 |
|------|------|------|------|
| `hn` | `hermes-note` | 新建/更新知识 | `hn "你的知识内容"` |
| `ha` | `hermes-apply` | 应用合并 | `ha "概念名_merge_xxx.md"` |

**调用方式（二选一）：**
```bash
# 方式1：直接调用脚本（推荐，绕过别名问题）
~/bin/hermes-note "解释Transformer"
~/bin/hermes-apply "Transformer_merge_xxx.md"

# 方式2：确保 ~/bin 在 PATH 后用别名
export PATH="$HOME/bin:$PATH"
hn "解释Transformer"
ha "Transformer_merge_xxx.md"
```

**hn 工作流程：**

```
hn "解释Transformer"
  → 调用 Hermes CLI 生成结构化 Markdown
  → 自动分类（AI/Business/Personal/Misc）
  → 判断是否已有该概念（通过 Canonical Concept 匹配）
    ├── 没有 → 直接创建正式文件
    └── 有 → 生成合并候选到 MergeQueue/
```

**ha 工作流程：**

```
ha "Transformer_merge_20260420_010423.md"
  → 备份旧版到 Archive/
  → 用合并稿替换正式文件
  → 删除合并候选稿
```

### 4.2 验证测试

刚才测试 `hn "测试知识输入"` 成功生成了 `Knowledge/Misc/测试.md`，内容完全符合模板格式。

### 4.3 hn/ha 工作流

---

## 五、会话归档系统（已实现）

### 5.1 自动归档

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

### 5.2 增量更新

同一个 session ID 的会话继续时，新的对话内容会**覆盖更新**原有存档文件（而不是新建），确保一个会话只有一个文件。

### 5.3 GitHub 同步

归档后自动推送到 GitHub（`praxistech2026-eng/hermes-knowledge-base`）。

Mac 端 Obsidian Git 插件会自动 pull，手机端暂不支持。

---

## 六、当前状态与后续计划

### ✅ 已实现
- ✅ 会话自动归档（每小时一次）
- ✅ 增量更新机制
- ✅ GitHub 同步
- ✅ `hn` 命令（自然语言 → 知识卡片）
- ✅ `ha` 命令（合并候选 → 更新正式文件）
- ✅ 9 张知识卡片（AI类5张 + Business类1张 + 测试1张 + 待合并1张 + 备份1张）

### ❌ 待实现
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
