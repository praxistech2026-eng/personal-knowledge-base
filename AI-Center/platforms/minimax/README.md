# MiniMax

> MiniMax 是本系统的厂商档案；当前 LiteLLM 只注册 `MiniMax-M3` + `MiniMax-M2.7`。国内 Token Plan 走 OpenAI-compatible 路线，`M3` 做主力，`M2.7` 做稳定兜底。

## 官方资源

| 资源 | 链接 |
|------|------|
| 官网 | https://platform.minimaxi.com/ |
| API 文档 | https://platform.minimaxi.com/docs/api-reference/api-overview |
| 模型介绍 | https://platform.minimaxi.com/docs/guides/models-intro |
| GitHub | https://github.com/MiniMax-AI/MiniMax-M2.7 |

## 在本生态中的角色

**主模型体系**。MiniMax-M3 是当前主力推理模型，MiniMax-M2.7 作为稳定兜底；两者一起覆盖当前 LiteLLM 的默认可用面。

## 接入配置

```
API Endpoint: https://api.minimaxi.com/v1
模型: MiniMax-M3 / MiniMax-M2.7
认证: Bearer Subscription Key (Token Plan)
```

> 凭证保存在 `MINIMAX_CN_API_KEY`
> 入口主机保存在 `MINIMAX_CN_API_HOST=https://api.minimaxi.com/v1`
> 当前工作区验证的是 OpenAI-compatible；Anthropic 口不作为默认落地口。

## 模型规格（当前 LiteLLM 已注册）

| 模型 | 上下文 | 特性 |
|------|--------|------|
| MiniMax-M3 | 1,000,000 tokens | 文本 / 图像 / 视频 / tool use / reasoning，主力模型 |
| MiniMax-M2.7 | 204,800 tokens | 文本 + tool-call，稳定兜底 |

> 官方 docs 还列出 `MiniMax-M2.7-highspeed` / `MiniMax-M2.5` / `MiniMax-M2.5-highspeed` / `MiniMax-M2.1` / `MiniMax-M2.1-highspeed` / `MiniMax-M2`，但当前 LiteLLM 不默认注册。

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
| 通知渠道 | 暂未接入独立自动告警 | 现由巡检/人工发现补位 |
| 兜底动作 | 切到备选模型，再排查 MiniMax key | 先保可用 |
| 升级路径 | 先恢复调用，再决定是否换套餐 | 不硬扛 |

### 恢复 / 回滚

- 恢复 `.env` 中正确的 key
- 必要时把默认模型切回备选提供商

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-20 | 复核 MiniMax CN Token Plan 官方文档，LiteLLM 只保留 `MiniMax-M3` + `MiniMax-M2.7`，并用 `/v1/chat/completions` 验证通过 |
| 2026-04 | 接入作为主模型 |
