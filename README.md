# Hermes Knowledge OS (v1)

## 🧠 系统定位

这是一个**半自动知识操作系统（Knowledge OS）**，核心能力是：

- 将自然语言转化为结构化知识
- 自动分类、补充关系与标签
- 自动识别已有概念
- 支持知识的“增量更新与演化”（而不是重复创建）

---

## 🚀 核心命令

### 1. 新建 / 输入知识

```bash
hn "解释什么是Transformer模型"
```

系统会：

- 生成结构化 Markdown
- 自动分类（AI / Business / Personal / Misc）
- 自动补充 Tags / Relations
- 自动归一 Canonical Concept

---

### 2. 增量更新已有知识

```bash
hn "详细解释Transformer的编码器和解码器结构"
```

系统行为：

- 如果命中已有概念（如 Transformer）
  - 不新建文件
  - 在 `MergeQueue/` 生成合并候选稿

---

### 3. 查看合并候选

在 Obsidian 或文件系统中查看：

```
Knowledge/MergeQueue/
```

---

### 4. 应用合并（更新知识）

```bash
ha "Transformer_merge_xxx.md"
```

系统会：

- 替换正式文件（如 Transformer.md）
- 自动备份旧版本到 Archive
- 删除候选稿

---

## 📁 目录结构

```
Knowledge/
├── AI/
├── Business/
├── Personal/
├── Misc/
├── Inbox/
├── MergeQueue/
├── Archive/
├── Review/
```

---

## ⚙️ 自动任务（cron）

系统每分钟执行：

- 自动 Git 同步
- 自动分类
- 自动补充 Tags / Relations

---

## 🧩 核心原则（非常重要）

### 1. 文件名 = Canonical Concept

必须满足：

```
一个概念 = 一个文件
```

正确示例：

```
Transformer.md
Attention机制.md
位置编码.md
```

错误示例（禁止）：

```
Transformer模型.md ❌
Transformer架构.md ❌
Transformer详解.md ❌
```

---

### 2. Canonical Concept 必须归一

必须是：

- 最基础概念
- 不带修饰词
- 不带“详解 / 架构 / 原理”等

示例：

```
Transformer 架构 → Transformer
Transformer 编码器 → Transformer
自注意力 → Attention机制
```

---

### 3. 不要手动新建知识文件

必须通过：

```bash
hn "内容"
```

---

### 4. MergeQueue 是审核区

- 所有合并必须先进入 MergeQueue
- 不要直接覆盖正式文件
- 使用 `ha` 进行替换

---

### 5. Archive 只用于回滚

不要删除：

```
*_backup_*.md
```

---

## ⚠️ 常见错误

### ❌ 错误1

```bash
ha Transformer.md
```

✔ 正确：

```bash
ha "Transformer_merge_xxx.md"
```

---

### ❌ 错误2

```bash
ha Transformer merge.md
```

✔ 正确：

```bash
ha "Transformer_merge_xxx.md"
```

---

### ❌ 错误3：概念分裂

```
Transformer.md
Transformer架构.md
Transformer模型.md
```

→ 必须只保留一个

---

## 🔥 工作流

```
输入
→ 生成
→ 分类
→ 增强
→ 概念归一
→ 判断是否已有概念
    → 否：新建
    → 是：生成合并候选
→ 人工确认
→ 更新主节点
```

---

## 🧠 系统本质

不是笔记工具，而是：

> 一个“会进化的知识系统”

---

## 📌 v1 状态

- 半自动
- 可控
- 可演化

---

## 🧩 使用建议

- 每天使用 `hn`
- 定期查看 `MergeQueue`
- 高质量再执行 `ha`
- 优先稳定，不追求全自动

---

## ✅ 一句话总结

```
不要让知识越来越多，
要让知识越来越准
```
