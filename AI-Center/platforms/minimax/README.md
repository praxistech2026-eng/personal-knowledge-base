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

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | MiniMax API 配置与 `MINIMAX_CN_API_KEY` | 无本地进程，检查凭证与调用能力 |
| 检查命令 | `hermes config check`；执行一次最小模型调用 | 以成功调用为准 |
| 判据 | 能通过 Hermes 正常完成一次模型调用 | 凭证可用 |
| 频率 | 改 key / 改套餐 / 改路由后 | 变更即查 |
| 失败动作 | 先核验 key、套餐与 endpoint，再回滚到备选模型 | 先路由后模型 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/.hermes/.env` 中的 `MINIMAX_CN_API_KEY`、模型路由配置 | 核心凭证与路由 |
| 备份方式 | `.env` 备份 + Git 记录非敏感配置 | 不写明文 |
| 频率 | 改动前备份 | 凭证先备份 |
| 保留策略 | 保留最近可回滚版本 | 足够回退即可 |
| 恢复命令 | 恢复 `.env` 后重新 `hermes config check` | 回滚后验 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | 调用失败、鉴权失败、限流 / 套餐不可用 | 任一即异常 |
| 通知渠道 | 当前无自动告警 | 先人工发现 |
| 兜底动作 | 切到备选模型，再排查 MiniMax key | 先保可用 |
| 升级路径 | 先恢复调用，再决定是否换套餐 | 不硬扛 |

### 恢复 / 回滚

- 恢复 `.env` 中正确的 key
- 必要时把默认模型切回备选提供商

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 接入作为主模型 |
