# Agnes LiteLLM 验证记录（2026-06-21）

## 目标

把 Agnes 从“已接入但多模态配置错误”的状态，修正为 LiteLLM 中**可真实调用**的文本 / 图像 / 视频模型集合。

## 最终结果

- 已保留：`Agnes-2.0-flash`、`Agnes-image-2.1-flash`、`Agnes-video-v2.0`
- 已移除：`Agnes-1.5-flash`、`Agnes-image-2.0-flash`
- 未注册：`Agnes-video-v2.1`（上游无可用 channel）

## 实测证据

### `/v1/models`
Agnes 最终只暴露 3 个唯一模型：
- `Agnes-2.0-flash`
- `Agnes-image-2.1-flash`
- `Agnes-video-v2.0`

### 图像路由
请求：`POST /v1/images/generations`

最小 payload：
```json
{
  "model": "Agnes-image-2.1-flash",
  "prompt": "a minimalist black cat logo on white background",
  "size": "1024x768"
}
```

结果：**200**，返回图片 URL。

### 视频路由
请求：`POST /v1/videos`

最小 payload：
```json
{
  "model": "Agnes-video-v2.0",
  "prompt": "a cat walking on grass",
  "seconds": "5"
}
```

结果：**200**，返回 `queued` 状态的视频任务对象。

追加请求：`GET /v1/videos/{id}`

结果：**200**，状态查询成功。

## 根因

不是 Agnes 模型挂了，而是**注册时没有先判定多模态 endpoint**：
- 文本模型应该走 `/v1/chat/completions`
- 图像模型应该走 `/v1/images/generations`
- 视频模型应该走 `/v1/videos`

如果把图像 / 视频模型当聊天模型注册，LiteLLM 会把请求扔进 `/v1/chat/completions`，结果就是 404。

## 值得沉淀的经验

1. **厂商页有模型 ≠ 可以直接按 chat 模型注册。**
2. 新模型接入时必须先判定 endpoint 家族，再决定 `model_info.mode`。
3. 多模态模型的验收标准不能只看 `/v1/models`，必须打对口 endpoint。
4. 最小 payload 先跑通，再加供应商私有参数；否则一堆 400 看起来像厂商故障，其实是请求形状有问题。
5. 视频生成要额外校验状态查询接口，不是创建成功就算完成。

## 直接影响到的工作流修正

这次经验已经补进 `mlops/litellm` skill，新增强制门槛：
- 先读官方文档
- 先直打上游
- 显式映射 endpoint → `model_info.mode`
- 重启后验证 `/v1/models` + 正确 endpoint
- 把特殊参数坑立刻写回 skill
