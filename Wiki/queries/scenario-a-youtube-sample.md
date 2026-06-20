---
title: Scenario A YouTube sample
created: 2026-06-17
updated: 2026-06-17
type: query
tags: [pkm, query, ingestion, media, needs-review]
sources: [/home/shin/PersonalKnowledge/Wiki/raw/video/2026-06-04-youtube-rick-astley-never-gonna-give-you-up.md, /home/shin/PersonalKnowledge/Conclusions/_staging/video_20260604_110453_Rick_Astley_-_Never_Gonn.md]
confidence: medium
status: active
---

# Scenario A YouTube sample

本页记录场景 A 的第一条实跑样本：YouTube 链接 `https://www.youtube.com/watch?v=dQw4w9WgXcQ`。  
相关页面：[[video-link-ingestion]]、[[knowledge-compilation-layer]]

## 这次跑通了什么

- 链接进入 staging 成功
- canonical URL 保留下来了
- 作者、时长、封面、描述都拿到了
- 生成了 `raw/video` 快照
- 已经能开始把结果编译进 Wiki，而不是只停在 `_staging`

## 这次没那么漂亮的地方

- 转写来自 ASR，不是原生字幕，质量明显一般
- 摘要里能看到转写污染，不能直接拿去当正式知识结论
- 这说明 `transcript_first` 不等于 `summary_ready`

## 对当前工作流的判断

这条样本足以证明当前路线是对的：
1. 入口不是主要问题
2. staging 不是死胡同
3. Wiki 可以作为下一层编译出口接上去

但它也暴露了当前最该补的一刀：**编译层必须识别转写质量，不要把低质量 ASR 文本硬抬成高质量知识。**

## 下一步

- 对同类 YouTube 样本优先尝试原生字幕路径
- 把 staging 平铺字段继续映射到 Canonical Envelope
- 再用同一套路跑 B站 / 抖音 / 小红书样本，看哪些平台能稳定进入可编译状态
