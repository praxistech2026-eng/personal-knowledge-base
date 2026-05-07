# Sessions Index

所有对话 session 已归档至 Hindsight 向量数据库（fact_type=experience）。可通过 `hindsight_recall` 自然语言检索。

## 2026-05

| 日期 | session 数 | 代表主题 |
|------|-----------|---------|
| 05-07 | ~6 | Clash YAML 优化 / Session 归档设计 |
| 05-06 | ~25 | OpenClash / Oracle VPS / Git 冲突 / AI-Center |
| 05-05 | ~10 | HeroClash / 飞书集成 / 代理架构 |
| 05-02 | ~19 | 飞书配置 / Webhook / AI-Center 初始化 |

## 快速检索示例

```
# 检索"上次解决 Oracle VPS SSH 的会话"
hindsight_recall(query="Oracle VPS SSH recovery session")

# 检索"OpenClash 配置优化相关"
hindsight_recall(query="OpenClash YAML optimization strategy groups")
```

## 原始备份

全量原始 session 文件（压缩）位于 GitHub：
- `Sessions-Backup/sessions_2026-05-full.tar.zst`
- `Sessions-Backup/sessions_2026-04.tar.zst`

## fact_type 说明

| 值 | 含义 |
|----|------|
| `experience` | 完整 session 归档（Hindsight experience bank） |
| `world` | 知识库条目（AI 生产的文档） |

---
> 本文件由 session_to_hindsight.py 自动生成，每日在 gateway 归档后更新。
