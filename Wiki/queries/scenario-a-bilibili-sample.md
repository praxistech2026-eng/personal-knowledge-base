---
title: Scenario A Bilibili sample
created: 2026-06-18
updated: 2026-06-18
type: query
tags: [pkm, query, ingestion, media, needs-review]
sources: [/home/shin/PersonalKnowledge/Wiki/raw/video/2026-06-18-bilibili-codex-pitfalls-ak007.md, /home/shin/PersonalKnowledge/Conclusions/_staging/video_20260618_005558_花了一周半把我用codex的坑全部总结了出来_如.md]
confidence: medium
status: active
---

# Scenario A Bilibili sample

本页记录你刚给的 B 站链接实跑结果：`https://www.bilibili.com/video/BV1DmjV6vEiG/?spm_id_from=333.1007.tianma.5-4-18.click`。  
相关页面：[[video-link-ingestion]]、[[knowledge-compilation-layer]]、[[scenario-a-youtube-sample]]

## 结论

这条链接已经被成功转成**可沉淀的知识中间产物**，不是只有标题：
- 拿到了标题、作者、时长、封面、描述、Video ID
- 成功生成 staging 知识卡
- 成功落了 raw/video 快照
- 成功写入 Wiki 查询页

## 真实边界

这次不是完美成功，而是**可用但不优雅**：
- 裸 `yt-dlp` 直打会被 B站 412 拦下
- 复用真实 Firefox profile 后，metadata 能拿到
- 这条视频没有拿到字幕，最后走了音轨 + ASR
- 当前 ASR 使用的是 `openai-whisper tiny` fallback，文本质量一般

## 这说明什么

1. B站链接不能靠“裸链接 + 默认下载器”硬打，必须有平台工作流。
2. 真正可用的链路应该是：cookies 会话复用 → metadata → 字幕优先 → 无字幕时 ASR。
3. 现在这条内容已经够进入知识库的待确认层，但还不够直接升格为高置信正式知识。

## 最值得修的地方

- B站 canonical URL 还带着 `spm_id_from` 查询参数，去重归一化还不够狠
- faster-whisper 本地模型没准备好，导致退回 tiny 模型，转写质量拉胯
- 若要做高质量沉淀，下一步该补字幕优先策略和更强 ASR 配置
