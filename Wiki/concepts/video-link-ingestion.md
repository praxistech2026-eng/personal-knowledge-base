---
title: Video link ingestion
created: 2026-06-17
updated: 2026-06-17
type: concept
tags: [pkm, ingestion, workflow, media, stable]
sources: [/home/shin/PersonalKnowledge/AI-Center/docs/个人知识沉淀系统-设计文档.md, /home/shin/PersonalKnowledge/AI-Center/docs/知识摄入解析层与统一内容包规范.md, /home/shin/PersonalKnowledge/Wiki/raw/video/2026-06-04-youtube-rick-astley-never-gonna-give-you-up.md]
confidence: high
status: active
---

# Video link ingestion

视频链接摄入的目标不是“拿到一个标题”，而是尽量拿到 `canonical_url + metadata + transcript/description + provenance`，然后再进入知识编译。  
相关页面：[[knowledge-compilation-layer]]、[[scenario-a-youtube-sample]]

## 当前有效链路

1. 用户给链接或分享文本
2. `process-inbox-safe.py` 识别平台、展开短链、确定 canonical URL
3. 根据平台尝试字幕 / 音频 / 浏览器 metadata
4. 输出 staging 卡到 `Conclusions/_staging/`
5. 再编译为 `Wiki/raw/video/*` 和正式概念/查询页

## 质量分层

- `transcript_first`：拿到了可用字幕或转写，适合进入编译层
- `metadata_only`：只有标题、作者、时长等，适合保留但不宜高置信总结
- `manual_review`：有内容但风险高，先别升格
- `failed`：只保留原始入口与失败原因

## 当前实现和规范的差距

规范里要求的是 `source / identity / artifacts / metadata / quality / provenance` 六块；现在 staging 样本还是 `source_url / canonical_url / platform_tag / quality_tag` 这种扁平字段。说明方向对了，接口还没归一。

## 场景 A 的默认验收标准

- 成功产出 raw/video 页面
- 成功产出至少 1 个 concept 页面
- 成功产出至少 1 个 query 页面
- `index.md` 与 `log.md` 同步更新
- 能明确指出这次样本是高质量可编译，还是只能保留为低质量证据
