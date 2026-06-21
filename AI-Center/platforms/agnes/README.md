# Agnes AI

> Agnes AI 是当前 LiteLLM 中已落地验证的外部模型提供商。2026-06-21 已完成多模态注册纠偏：文本只保留 `Agnes-2.0-flash`，图像走 `Agnes-image-2.1-flash`，视频走 `Agnes-video-v2.0`。

## 官方资源

| 资源 | 链接 |
|------|------|
| 官网 | https://agnes-ai.com/ |
| API 文档首页 | https://agnes-ai.com/doc |
| 概览 | https://agnes-ai.com/doc/overview |
| 文本模型 | https://agnes-ai.com/doc/agnes-20-flash |
| 图像模型 | https://agnes-ai.com/doc/agnes-image-21-flash |
| 视频模型 | https://agnes-ai.com/doc/agnes-video-v20 |

## 在本生态中的角色

**新增多模态补位厂商**。Agnes 当前不是主模型体系，而是 LiteLLM 中用于补充图像 / 视频生成能力的外部提供商；文本只保留 `Agnes-2.0-flash` 作为同厂商最小可用文本入口。

## 接入配置

```
API Endpoint: https://apihub.agnes-ai.com/v1
认证: Bearer API Key
协议: OpenAI-compatible
```

> 凭证通过 `AGNES_CODING_API_KEY` 注入 LiteLLM 容器。
> 当前验证对象是本地 LiteLLM Docker 栈：`/home/shin/workspace/litellm/config.yaml`

## 当前 LiteLLM 已注册模型（2026-06-21 实测）

| LiteLLM alias | 官方 model_id | 类型 | 正确入口 | 实测结果 |
|---|---|---|---|---|
| `Agnes-2.0-flash` | `agnes-2.0-flash` | 文本 | `/v1/chat/completions` | 200 |
| `Agnes-image-2.1-flash` | `agnes-image-2.1-flash` | 图像生成 | `/v1/images/generations` | 200 |
| `Agnes-video-v2.0` | `agnes-video-v2.0` | 视频生成 | `/v1/videos` | 200 |

## 已下线 / 不再注册

| 模型 | 原因 |
|---|---|
| `Agnes-1.5-flash` | 与 `Agnes-2.0-flash` 同属文本链路，按“最小必要集合”移除旧版本 |
| `Agnes-image-2.0-flash` | 同模态保留高版本 `2.1`，删掉旧版本 |
| `Agnes-video-v2.1` | 2026-06-21 实测上游未提供可用 channel，不注册 |

## 这次修正的核心结论

1. Agnes 不是“模型坏了”，而是**注册时把多模态模型错挂到了 chat 路由**。
2. `Agnes-image-2.1-flash` 必须通过 `model_info.mode: image_generation` 暴露到 `/v1/images/generations`。
3. `Agnes-video-v2.0` 必须通过 `model_info.mode: video_generation` 暴露到 `/v1/videos`。
4. `Agnes-1.5-flash` 和 `Agnes-video-v2.0` **不是重复功能**；前者是文本，后者是视频。

## USAGE_MANUAL

### 最小可用请求

#### 文本
```json
POST /v1/chat/completions
{
  "model": "Agnes-2.0-flash",
  "messages": [{"role": "user", "content": "hello"}]
}
```

#### 图像
```json
POST /v1/images/generations
{
  "model": "Agnes-image-2.1-flash",
  "prompt": "a minimalist black cat logo on white background",
  "size": "1024x768"
}
```

#### 视频
```json
POST /v1/videos
{
  "model": "Agnes-video-v2.0",
  "prompt": "a cat walking on grass",
  "seconds": "5"
}
```

### 已确认坑点

- **图像/视频不能走 `/v1/chat/completions`**，否则直接 404。
- `Agnes-image-2.1-flash` 在 LiteLLM 下先用最小 payload；额外传 `response_format` 会触发 unsupported-param 校验。
- `Agnes-video-v2.0` 的 `seconds` 需要传**字符串**，不能传 JSON number。
- 视频是异步任务，创建后还要用 `GET /v1/videos/{id}` 查状态。

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | LiteLLM 中的 Agnes 三个模型 | 以真实请求为准 |
| 检查命令 | `GET /v1/models` + 对应 endpoint 最小调用 | 不看静态配置自嗨 |
| 判据 | 文本 200、图像 200、视频创建 200、视频查询 200 | 四项全过才算真通 |
| 频率 | 改 config / 改 key / 改 LiteLLM 版本后 | 变更即查 |
| 失败动作 | 先核模态与 endpoint，再核 key 和上游可用性 | 不先甩锅给厂商 |

## 成本

官方页面未提供可直接落库的清晰价格表；目前仅确认其存在 API 平台与模型页。价格信息保持 **待核实**。

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-21 | 删除 `Agnes-1.5-flash` / `Agnes-image-2.0-flash`；保留并修正 `Agnes-2.0-flash`、`Agnes-image-2.1-flash`、`Agnes-video-v2.0`；重启 LiteLLM 后实测文本 / 图像 / 视频路由全部通过 |
| 2026-06-20 | 首次接入 Agnes 到 LiteLLM，但当时未完成多模态 endpoint 校验 |
