# Wiki Schema

## Domain
Shin 的个人知识编译层。这个 Wiki 只负责**组织、交叉链接、主题沉淀、关系维护**，不负责原始摄入。

上游分工固定：
- `_inbox/`：输入入口
- `process-inbox-safe.py` / 后续解析器：解析层
- `Conclusions/_staging/`：待确认与待编译层
- `Wiki/`：结构化知识编译层
- `AI-Center/`：运行系统与运维文档，不混入个人知识 Wiki

## Non-goals
- 不把 session archive 写进这里
- 不把 AI-Center 运维档案搬进这里
- 不直接从原始输入跳过 staging 写 Wiki
- 不把 `raw/` 当成可编辑笔记区

## Structure
```text
Wiki/
├── SCHEMA.md
├── index.md
├── log.md
├── raw/
│   ├── web/
│   ├── video/
│   ├── audio/
│   ├── documents/
│   ├── share-text/
│   └── assets/
├── entities/
├── concepts/
├── comparisons/
└── queries/
```

## Conventions
- 文件名：`lowercase-hyphen.md`
- 页面标题用自然语言；文件名用稳定 slug
- 所有 Wiki 页面都必须带 YAML frontmatter
- 所有页面至少有 2 个 `[[wikilinks]]`，否则就是孤岛
- 任何新页面都必须同步登记到 `index.md`
- 任何创建 / 更新 / 查询 / 归档动作都必须追加到 `log.md`
- `raw/` 只存原始材料或上游编译输入，默认不可人工改写
- `Conclusions/_staging/` 是上游待编译层，不算 Wiki 页面

## Source-of-truth Rules
1. 用户原始输入与抓取结果的事实源在 `_inbox/`、`_materials/`、`Conclusions/_staging/`
2. Wiki 页面是**编译产物**，允许被重写、合并、抽象
3. 有争议时，优先回链到 raw / staging / 原始链接，而不是在 Wiki 页面里硬改历史

## Page Frontmatter
```yaml
---
title: Page Title
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: entity | concept | comparison | query | summary
tags: [pkm, ingestion]
sources: [raw/video/example.md, ../Conclusions/_staging/example.md]
confidence: high | medium | low
status: active | draft | contested | archived
---
```

## Raw Frontmatter
`raw/` 下的 markdown 原始材料建议使用：

```yaml
---
source_url: https://example.com
source_input_path: /absolute/path/or/original/share-text.txt
ingested: YYYY-MM-DD
source_type: web | video | audio | document | share_text
sha256: <body hash>
---
```

## Tag Taxonomy
只允许先登记、后使用。当前首批标签：

### Knowledge function
- `pkm`
- `workflow`
- `ingestion`
- `compilation`
- `retrieval`
- `taxonomy`

### Content domain
- `ai`
- `automation`
- `marketing`
- `business`
- `tooling`
- `research`
- `media`

### Page semantics
- `entity`
- `concept`
- `comparison`
- `query`
- `playbook`
- `system`

### Quality / state
- `draft`
- `stable`
- `contested`
- `needs-review`

## Page Thresholds
- **Create entity/concept page**：同一主题在 2 个以上来源里反复出现，或单一来源但足够核心
- **只更新现有页**：只是补充事实、例子、关系
- **不要建页**：随手一提、短期价值低、没有后续复用空间
- **拆页**：页面超过 200 行，或同时混入多个不同主题

## Compilation Rules
从 staging 编译到 Wiki 时：
1. 先判断是 entity / concept / comparison / query 哪一类
2. 把确定性字段保留为 provenance，不要丢原始链接与来源
3. 摘要可以重写，但事实不能脱离来源
4. 视频类优先保留 transcript / description / canonical_url
5. 低质量转写不能直接升格为高置信知识

## Query Filing Rules
以下回答值得沉淀到 `queries/`：
- 已经跨 2+ 页面综合
- 有明确结论与适用边界
- 未来大概率还会再问

以下不值得：
- 单次查找
- 简单目录导航
- 临时故障提示

## Lint Rules
健康检查至少覆盖：
- orphan pages
- broken wikilinks
- index 漏登记
- tags 未登记
- sources 缺失
- `status: contested` 页面
- 超过 200 行的大页

## Initial Workflow
- 先从 `Conclusions/_staging/` 挑一个高频场景样本
- 生成 raw 记录
- 再编译出第一批 concept / query 页面
- 最后把结果回填到 `index.md` 与 `log.md`
