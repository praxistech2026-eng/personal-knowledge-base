# LiteLLM ChatGPT 健康检查误报

## Summary
LiteLLM 的 ChatGPT 订阅模型可以真实可用，但 health status 可能误报 unhealthy，因为默认 health probe 走 `responses` 路径时把 `input` 传成字符串 `"test"`。ChatGPT `responses` 端点要求 `input` 是 list，字符串会触发 `BadRequestError: Input must be a list`。

## Primary Concept
这是一个健康检查 payload 形状不匹配的问题，不是模型配置或订阅失效。

## Key Points
- `chat/completions` 业务调用可以正常返回，不等于 health probe 通过。
- `GET /v1/models` 只代表模型被注册暴露，不代表健康检查真实成功。
- `GET /health?model_id=<internal_id>` 才是实际 health probe 结果。
- 根因是 LiteLLM 对 ChatGPT provider 的 `responses` 健康探测请求形状错误。
- 本环境通过 `patches/sitecustomize.py` 在启动时只修正 ChatGPT 的 health probe input。
- `config.yaml` 没有改模型定义；模型配置不应因为健康误报而回滚。
- 这类问题的判断标准是：**先分清“注册可见”和“真实健康”**，不要把页面绿灯当成调用能力本身。

## References
- `AI-Center/credentials/LiteLLM-模型配置方法.md`
- `AI-Center/credentials/LLM-模型可用性快照-2026-05-20.md`
- `AI-Center/docs/AI-Center-拓扑图.md`

## Tags
#litellm #chatgpt #health-check #responses-api #model-gateway #obsidian
