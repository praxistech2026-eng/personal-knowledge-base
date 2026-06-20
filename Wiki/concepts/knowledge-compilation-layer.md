---
title: Knowledge compilation layer
created: 2026-06-17
updated: 2026-06-17
type: concept
tags: [pkm, workflow, compilation, system, stable]
sources: [/home/shin/PersonalKnowledge/AI-Center/docs/个人知识沉淀系统-设计文档.md, /home/shin/PersonalKnowledge/AI-Center/docs/知识摄入解析层与统一内容包规范.md, /home/shin/PersonalKnowledge/Wiki/raw/video/2026-06-04-youtube-rick-astley-never-gonna-give-you-up.md]
confidence: high
status: active
---

# Knowledge compilation layer

知识编译层的作用不是抓内容，而是把上游已经拿到的内容，整理成可维护、可交叉引用、可回溯的知识页面。

当前体系的正确顺序已经定死：`_inbox` → 解析层 → `Conclusions/_staging/` → `Wiki/`。这意味着 `Wiki/` 不该碰原始热路径，也不该承担下载器、转写器、短链展开器的职责。它只做组织、抽象、链接、沉淀。  
相关页面：[[video-link-ingestion]]、[[scenario-a-youtube-sample]]

## 为什么这一层必须独立

1. 原始抓取会失败、降级、补抓，不能把这些噪音直接烙进正式知识页。
2. staging frontmatter 现在还是偏脚本字段，不适合作为长期阅读界面。
3. 真正可复用的知识，需要跨样本整理，不是把单条视频卡直接丢进 Vault 就算完。

## 当前边界

- `AI-Center/`：解释系统怎么跑
- `Conclusions/_staging/`：保留待确认和失败不丢的中间产物
- `Wiki/raw/`：给知识编译层保留可追溯输入快照
- `Wiki/concepts|queries|comparisons`：输出长期可复用页面

## 当前仍未完全闭合的地方

- `process-inbox-safe.py` 还没直接产出 Canonical Envelope 顶层结构
- 视频样本虽然能落 staging，但字段仍然是平铺 frontmatter
- `Knowledge/` 里还残着旧分类目录，说明旧结构还没彻底收尸
