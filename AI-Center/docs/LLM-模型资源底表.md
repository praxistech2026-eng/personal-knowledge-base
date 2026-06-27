
# LLM 模型资源底表

> 更新时间：2026-06-27 14:17:41 CST
> 口径：只收本仓库已研究、已实测、已写回的资源；未核实项统一标为 `待核实`，不拿猜测填空。
> 状态取值：`已接入` / `未接入（待核实）` / `未接入（权限/限流）` / `未接入（白名单/支持集外）` / `未接入（环境限制）`
> 读法：先看“目前是否接入”，再看“接入需要的条件”，最后看“适配/原因”。
>
> **本表是当前现态唯一来源。** 旧设计文档、历史健康快照、研究报告里的配额/状态/限流数值只保留历史语境，不作为现态判断依据。

## 1. 模型资源底表

### 1.1 MiniMax（中国区 Token Plan）

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| MiniMax | MiniMax Token Plan | 文本 / 推理 / 多模态 | MiniMax-M3 | 中国区 Token Plan Subscription Key + `https://api.minimaxi.com/v1` | 已接入 | OpenAI-compatible 主力模型；当前 LiteLLM 主路由之一。 |
| MiniMax | MiniMax Token Plan | 文本 + tool-call blocks | MiniMax-M2.7 | 中国区 Token Plan Subscription Key + `https://api.minimaxi.com/v1` | 已接入 | OpenAI-compatible 稳定兜底；当前 LiteLLM 主路由之一。 |
| MiniMax | MiniMax Token Plan | 语音 / TTS | MiniMax-speech-2.8-hd | 必须走真实 `/v1/audio/speech` 验收；不要用 chat-style health 代替 | 已接入 | 已注册到 LiteLLM；语音能力单独验收。 |
| MiniMax | MiniMax Token Plan | 语音 / TTS | MiniMax-speech-2.8-turbo | 必须走真实 `/v1/audio/speech` 验收；不要用 chat-style health 代替 | 已接入 | 已注册到 LiteLLM；语音能力单独验收。 |
| MiniMax | MiniMax Token Plan | 文本（高频 / 快速档） | MiniMax-M2.7-highspeed | Token Plan 支持该变体；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方支持但当前 LiteLLM 不默认挂载。 |
| MiniMax | MiniMax Token Plan | 文本 | MiniMax-M2.5 | Token Plan 支持该模型；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方文档支持，当前仅保留更小稳定集合。 |
| MiniMax | MiniMax Token Plan | 文本（高频 / 快速档） | MiniMax-M2.5-highspeed | Token Plan 支持该变体；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方支持但当前不进主池。 |
| MiniMax | MiniMax Token Plan | 文本 | MiniMax-M2.1 | Token Plan 支持该模型；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方支持但当前不进主池。 |
| MiniMax | MiniMax Token Plan | 文本（高频 / 快速档） | MiniMax-M2.1-highspeed | Token Plan 支持该变体；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方支持但当前不进主池。 |
| MiniMax | MiniMax Token Plan | 文本 | MiniMax-M2 | Token Plan 支持该模型；当前工作区未默认注册 | 未接入（白名单/支持集外） | 官方支持但当前不进主池。 |
| MiniMax | MiniMax Token Plan | 多模态 Text 01 | MiniMax-Text-01 | Token Plan 账号 + `/v1/chat/completions` 直连验收 | 未接入（待核实） | 调研中可调用，但当前 LiteLLM 不默认注册。 |

### 1.2 阿里云百炼 Bailian（Token Plan 团队版）

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-qwen3.7-max | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证 `chat/completions` 可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-qwen3.7-plus | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 轻量 | Bailian-qwen3.6-flash | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-kimi-k2.6 | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-glm-5.2 | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-MiniMax-M2.5 | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-deepseek-v4-flash | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 通用 | Bailian-deepseek-v4-pro | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 当前 8 个 active 条目之一；已验证可通。 |
| Bailian | Token Plan 团队版 | 文本 / 旧版本 | Bailian-qwen3.6-plus | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 已移除：同池同能力面下被 `qwen3.7-plus` 压制。 |
| Bailian | Token Plan 团队版 | 编码 / 代码专项 | Bailian-kimi-k2.7-code | Token Plan 团队版白名单 | 未接入（白名单/支持集外） | Kimi 官方存在，但不在 Token Plan 白名单。 |
| Bailian | Token Plan 团队版 | 文本 / 旧版本 | Bailian-qwen3.5-plus | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 旧版本，当前不进主池。 |
| Bailian | Token Plan 团队版 | 文本 / 旧版本 | Bailian-qwen3-max-2026-01-23 | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 旧版本，当前不进主池。 |
| Bailian | Token Plan 团队版 | 编码 / 旧版本 | Bailian-qwen3-coder-next | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 旧版本，当前不进主池。 |
| Bailian | Token Plan 团队版 | 编码 / 旧版本 | Bailian-qwen3-coder-plus | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 旧版本，当前不进主池。 |
| Bailian | Token Plan 团队版 | 文本 / 旧版本 | Bailian-glm-4.7 | Token Plan 团队版白名单/当前 active 集合 | 未接入（白名单/支持集外） | 旧版本，当前不进主池。 |
| Bailian | Token Plan 团队版 | 图像生成 / 独立接口 | Bailian-qwen-image-2.0 | 独立图像接口；当前不进 LiteLLM 主 `model_list` | 未接入（待核实） | 保留在 bridge / pending；不强塞主池。 |
| Bailian | Token Plan 团队版 | 图像生成 / 独立接口 | Bailian-qwen-image-2.0-pro | 独立图像接口；当前不进 LiteLLM 主 `model_list` | 未接入（待核实） | 保留在 bridge / pending；不强塞主池。 |
| Bailian | Token Plan 团队版 | 图像生成 / 独立接口 | Bailian-wan2.7-image | 独立图像接口；当前不进 LiteLLM 主 `model_list` | 未接入（待核实） | 保留在 bridge / pending；不强塞主池。 |
| Bailian | Token Plan 团队版 | 图像生成 / 独立接口 | Bailian-wan2.7-image-pro | 独立图像接口；当前不进 LiteLLM 主 `model_list` | 未接入（待核实） | 保留在 bridge / pending；不强塞主池。 |

### 1.3 Volcengine / ARK Coding Plan

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| Volcengine | ARK Coding Plan | 代码 / 自动路由 | Volcengine-ark-code-latest | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 控制台切档位的别名；当前报 `InvalidSubscription` / `AccessDenied`。 |
| Volcengine | ARK Coding Plan | 代码 | Volcengine-doubao-seed-2.0-code | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 推理 / 代码 | Volcengine-doubao-seed-2.0-pro | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 轻量代码 | Volcengine-doubao-seed-2.0-lite | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 代码 | Volcengine-doubao-seed-code | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 文本 | Volcengine-minimax-m2.5 | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 文本 | Volcengine-glm-4.7 | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 文本 | Volcengine-deepseek-v3.2 | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |
| Volcengine | ARK Coding Plan | 文本 | Volcengine-kimi-k2.5 | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 未接入（权限/限流） | 当前订阅/访问权限不通过。 |

### 1.4 Agnes AI

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| Agnes | Agnes API | 文本 | Agnes-2.0-flash | Agnes API Key + `/v1/chat/completions` | 已接入 | 已按文本模型注册；直连可用。 |
| Agnes | Agnes API | 图像 | Agnes-image-2.1-flash | Agnes API Key + `/v1/images/generations` | 已接入 | 已分流到图像端点；`response_format` 之类私有参数需谨慎。 |
| Agnes | Agnes API | 视频 | Agnes-video-v2.0 | Agnes API Key + `/v1/videos` + `GET /v1/videos/{id}` | 已接入 | 已分流到视频端点；`seconds` 传字符串。 |
| Agnes | Agnes API | 旧文本 | Agnes-1.5-flash | Agnes API Key + `/v1/chat/completions` | 未接入（白名单/支持集外） | 旧版本，按最小必要集合移除。 |
| Agnes | Agnes API | 旧图像 | Agnes-image-2.0-flash | Agnes API Key + `/v1/images/generations` | 未接入（白名单/支持集外） | 旧版本，保留 2.1。 |
| Agnes | Agnes API | 旧视频 / 无 channel | Agnes-video-v2.1 | Agnes API Key + 对口视频 channel | 未接入（环境限制） | 上游未提供可用 channel。 |

### 1.5 SenseNova

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| SenseNova | SenseNova API | 文本 / 轻量 / 图片输入 | SenseNova-sensenova-6.7-flash-lite | SenseNova API Key + `https://token.sensenova.cn/v1` | 已接入 | 支持 `image_url` 图片输入块；当前 LiteLLM active。 |
| SenseNova | SenseNova API | 文本 / thinking / tool calling | SenseNova-deepseek-v4-flash | SenseNova API Key + `https://token.sensenova.cn/v1` | 已接入 | 支持 thinking / non-thinking、tool calling、JSON 输出。 |
| SenseNova | SenseNova API | 图片生成 | SenseNova-sensenova-u1-fast | SenseNova API Key + `POST https://token.sensenova.cn/v1/images/generations` | 已接入 | 已按独立图片生成端点接入，不走通用 chat endpoint。 |

### 1.6 AtomGit / GitCode / AtomCode

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| AtomGit | AtomCode 运行时 | 文本 / 代码 | deepseek-v4-flash | AtomGit OAuth / AtomGit AI Access Token；仅 AtomCode 环境放行 | 未接入（环境限制） | AtomCode 独享，仅允许 AtomCode 环境下使用。 |
| AtomGit | AtomCode 运行时 | 文本 / 代码 | Qwen/Qwen3.6-35B-A3B | AtomGit OAuth / AtomGit AI Access Token；仅 AtomCode 环境放行 | 未接入（环境限制） | AtomCode 独享，仅允许 AtomCode 环境下使用。 |
| AtomGit | AtomCode 运行时 | 视觉 / 预处理 | Qwen/Qwen3-VL-8B-Instruct | AtomGit OAuth / AtomGit AI Access Token；仅 AtomCode 环境放行 | 未接入（环境限制） | AtomCode 独享，常作为 vision_preprocessor_provider。 |
| AtomGit | 官方社区 API | 文本（官方示例） | deepseek-ai/DeepSeek-R1 | AtomGit 官方 API 文档示例 + 对应 access token | 未接入（待核实） | 仅在官方文档示例中出现，当前工作区未做本地验收。 |

### 1.7 ChatGPT / OpenAI（Codex backend）

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| ChatGPT | ChatGPT OAuth / Codex backend | 推理 / 视觉 / 通用 | ChatGPT-gpt-5.5 | ChatGPT OAuth / Codex backend token + `https://chatgpt.com/backend-api/codex` | 已接入 | 已挂在 `/v1/models`；health probe 需修正 `responses` 输入形状。 |
| ChatGPT | ChatGPT OAuth / Codex backend | 通用 / 写作 | ChatGPT-gpt-5.4 | ChatGPT OAuth / Codex backend token + `https://chatgpt.com/backend-api/codex` | 已接入 | 已挂在 `/v1/models`；health probe 修复后可用。 |
| ChatGPT | ChatGPT OAuth / Codex backend | 通用 / 轻量 | ChatGPT-gpt-5.4-mini | ChatGPT OAuth / Codex backend token + `https://chatgpt.com/backend-api/codex` | 已接入 | 已挂在 `/v1/models`；常用于默认文案/轻量任务。 |
| ChatGPT | ChatGPT OAuth / Codex backend | 编码 / 代码 | ChatGPT-gpt-5.3-codex | ChatGPT OAuth / Codex backend token + `https://chatgpt.com/backend-api/codex` | 已接入 | 已挂在 `/v1/models`；代码路由里作为编码最强档。 |

### 1.8 Gemini / Google（研究中，当前跳过）

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| Gemini | Google Gemini | 通用 / Flash | gemini-3.5-flash | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 策略文档里保留了路由评分，但当前用户拍板先跳过。 |
| Gemini | Google Gemini | 推理 / Pro preview | gemini-3.1-pro-preview | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 策略文档里保留了路由评分，但当前用户拍板先跳过。 |
| Gemini | Google Gemini | 轻量 / Flash-Lite | gemini-3.1-flash-lite | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 策略文档里保留了路由评分，但当前用户拍板先跳过。 |
| Gemini | Google Gemini | 轻量 / Flash-Lite preview | gemini-3.1-flash-lite-preview | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 策略文档里保留了路由评分，但当前用户拍板先跳过。 |
| Gemini | Google Gemini | 通用 / Flash preview | gemini-3-flash-preview | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 策略文档里保留了路由评分，但当前用户拍板先跳过。 |
| Gemini | Google Gemini | 推理 / Pro | gemini-2.5-pro | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 当前策略中作为高质量推理候选，现态跳过。 |
| Gemini | Google Gemini | 通用 / Vision | gemini-2.5-flash | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 当前策略中作为 vision/default 候选，现态跳过。 |
| Gemini | Google Gemini | 轻量 / Flash-Lite | gemini-2.5-flash-lite | 个人账号/AI Studio 配额 + 当前账户未被 429 限流 | 未接入（权限/限流） | 当前策略中作为 cheapest 候选，现态跳过。 |

## 2. 非模型资源底表（MCP / 插件 / 工具）

| 大模型厂商 | 子模型厂商/入口 | 子模型系列（能力向） | 子模型名称 | 接入需要的条件 | 目前是否接入 | 适配 / 原因 |
| --- | --- | --- | --- | --- | --- | --- |
| OpenClaw | OpenClaw Gateway | 内置工具集 | browser / file system / exec-runtime / session management / web / media | OpenClaw Gateway 18789 运行中 + gateway 配置启用 | 已接入 | 已启用内置工具集；作为 Hermes 底层执行层。 |
| OpenClaw | OpenClaw 平台插件 | 消息入口 | channels.feishu | 飞书 App Secret + 事件订阅 + 插件启用 | 已接入 | 已启用飞书机器人消息通道。 |
| OpenClaw | OpenClaw NPM 插件 | 消息入口 | @tencent-weixin/openclaw-weixin | WEIXIN_TOKEN + 账号绑定 + 插件路径 | 已接入 | 已启用微信消息通道。 |
| OpenClaw | OpenClaw 模型提供商插件 | 模型提供商 | volcengine | ARK API Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 已接入 | 作为 OpenClaw 侧可切换的备选模型提供商。 |
| MiniMax | 官方工具页 / MCP Integration | IDE / CLI / Agent tools | Claude Code / Cursor / Trae / OpenCode / Kilo Code / Cline / Grok CLI / Codex CLI / Droid | OpenAI-compatible `https://api.minimaxi.com/v1` 或 Anthropic-compatible `https://api.minimaxi.com/anthropic` + Token Plan Key | 已接入 | 官方明确支持；可复用到 Claude Code、OpenClaw、Codex 等工具面。 |
| Bailian | IDE 插件 / Agent tools | IDE / Agent tools | Claude Code / Kilo Code / Qwen Code / OpenClaw-type Agent | Token Plan 团队版 Key + `https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1` | 已接入 | 支持 Claude Code、Kilo Code、Qwen Code；Dify / n8n / Postman / 自定义后端脚本不支持。 |
| Volcengine | Coding tools | IDE / Agent tools | TRAE / OpenClaw / AI coding tools | ARK 编程计划 Key + `https://ark.cn-beijing.volces.com/api/coding/v3` | 已接入 | 官方实践文档以 TRAE / OpenClaw / AI coding tool 场景讲解。 |
| AtomGit / AtomCode | MCP client | MCP | .mcp.json（global / project） + `atomcode mcp add/reload/login` | AtomCode 环境 + AtomGit OAuth / Access Token | 已接入（环境限定） | AtomCode 内置 MCP 客户端；仅在 AtomCode 环境内放行。 |


## 3. 直接结论

1. **能进 LiteLLM 的，不是“配置简单”的模型，而是“能力面能被标准化表达”的模型。**
2. **图像 / 视频 / 音频 / MCP / 插件 / 工具面，一律先看 endpoint / 资源形态，再决定走 LiteLLM 还是原生 bridge。**
3. **当前现态里，MiniMax、Bailian、Agnes、SenseNova、ChatGPT 是可用主池；Volcengine 和 Gemini 处于未接入或权限/限流状态；AtomGit 只在 AtomCode 环境内放行。**
4. **OpenClaw 是执行层与插件层，不是模型厂商；它的工具与消息插件也应该进入你的资源底表。**

## 4. 主要来源

- `credentials/LLM-厂商配置基线.md`
- `credentials/LLM-模型可用性快照-2026-05-20.md`
- `docs/LiteLLM-健康快照-2026-06-15.md`
- `docs/MiniMax-TokenPlan-调研-2026-06-15.md`
- `docs/MiniMax-LiteLLM-接入复盘-2026-06-22.md`
- `docs/Bailian-LiteLLM-接入复盘-2026-06-22.md`
- `docs/Agnes-LiteLLM-验证-2026-06-21.md`
- `docs/模型调用策略-设计文档.md`
- `platforms/minimax/README.md`
- `platforms/volcengine/README.md`
- `platforms/openclaw/README.md`
- `platforms/feishu/README.md`
- `platforms/wechat/README.md`
- `docs/AI-Center-拓扑图.md`

## 5. 更新记录

- 2026-06-27：建立 `LLM-模型资源底表.md`，把模型、能力、MCP、插件、工具、消息入口统一收进当前现态总账，并挂入 `docs/WIKI-索引.md`。
- 2026-06-27：给 `docs/模型调用策略-设计文档.md` 增加历史口径说明，避免设计时快照被误读为当前现态。
- 2026-06-27：后续新增厂商/模型/能力/插件，先更新本表，再改索引与相关复盘文档。
