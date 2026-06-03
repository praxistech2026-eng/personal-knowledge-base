# MiniMax

> MiniMax 是本系统的主模型提供商，使用国内 Token Plan（Starter 29元/月）提供 M2.7 高性能大模型 API。

## 官方资源

| 资源 | 链接 |
|------|------|
| 官网 | https://platform.minimaxi.com/ |
| API 文档 | https://platform.minimaxi.com/docs/api-reference/api-overview |
| 模型介绍 | https://platform.minimaxi.com/docs/guides/models-intro |
| GitHub | https://github.com/MiniMax-AI/MiniMax-M2.7 |

## 在本生态中的角色

**主模型**。MiniMax-M2.7 是 Hermes Agent 的默认推理模型，提供 204,800 token 上下文窗口和 Agent 能力。

## 接入配置

```
API Endpoint: https://api.minimaxi.com/anthropic
模型: MiniMax-M2.7
认证: Bearer API Key
```

> 凭证保存在 `~/.hermes/.env` 的 `MINIMAX_CN_API_KEY`
> 套餐口径：国内 Starter 29元/月；不要再用国际站链接混写。

## 模型规格

| 模型 | 上下文 | 最大输出 | 特性 |
|------|--------|---------|------|
| MiniMax-M2.7 | 204,800 tokens | 131,072 tokens | Agent 优化，推理启用 |
| MiniMax-M2.7-highspeed | 同上 | 同上 | 同模型族，更快推理 |

## 成本

| 类型 | 价格 |
|------|------|
| 输入 | $0.3 / 1M tokens |
| 输出 | $1.2 / 1M tokens |
| 缓存读取 | $0.06 / 1M tokens |
| 缓存写入 | $0.375 / 1M tokens |

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 接入作为主模型 |
