# LLM 厂商配置基线

> 目标：只记录**你当前套餐实际支持的模型**、调用地址、特殊端点、工具/MCP 配置方式与验证日期。
> 统一规则：**厂商前缀 + 官方模型ID**。这里先存“官方原始模型ID”，后续由 LiteLLM 生成器拼装别名。
> 最后核验日期：2026-06-21

---

## 1) MiniMax / Token Plan（国内）

- **厂商简称**：MiniMax
- **凭证类型**：Token Plan Subscription Key
- **OpenAI Base URL（默认中国区）**：`https://api.minimaxi.com/v1`
- **Anthropic Base URL（默认中国区）**：`https://api.minimaxi.com/anthropic`
- **国际版备用**：`https://api.minimax.io/v1` / `https://api.minimax.io/anthropic`（仅在明确切换海外区域时使用）
- **官方模型 ID（文档支持，文本）**：
  - `MiniMax-M3`
  - `MiniMax-M2.7`
  - `MiniMax-M2.7-highspeed`
  - `MiniMax-M2.5`
  - `MiniMax-M2.5-highspeed`
  - `MiniMax-M2.1`
  - `MiniMax-M2.1-highspeed`
  - `MiniMax-M2`
- **当前 LiteLLM 实际注册**：
  - `MiniMax-M3`
  - `MiniMax-M2.7`
- **本套餐处理规则**：
  - 生产侧默认只保留 `M3` + `M2.7`
  - `M3` 做主力，`M2.7` 做稳定兜底
- **多模态 / 工具**：
  - `MiniMax-M3` 支持文本 / 图片 / 视频 / tool use / reasoning
  - `MiniMax-M2.7` 及同族支持文本 + tool-call content blocks
  - Token Plan quickstart 明确支持 AI Coding Tools、MCP Integration
- **MCP / 工具接入**：
  - 官方支持的工具页包含 Claude Code、Cursor、Trae、OpenCode、Kilo Code、Cline、Grok CLI、Codex CLI、Droid
  - 典型配置：OpenAI-compatible 场景设置 `OPENAI_BASE_URL=https://api.minimaxi.com/v1`，并把 `OPENAI_API_KEY` 指向 Subscription Key
- **官方来源**：
  - `https://platform.minimaxi.com/docs/guides/models-intro`
  - `https://platform.minimaxi.com/docs/guides/text-openai-api`
  - `https://platform.minimaxi.com/docs/api-reference/text-anthropic-api`
  - `https://platform.minimaxi.com/docs/token-plan/other-tools`
  - `https://platform.minimaxi.com/docs/guides/quickstart-preparation`

---

## 2) 阿里云百炼 / Pro 200元/月

- **厂商简称**：Bailian
- **凭证类型（当前）**：**Token Plan 团队版** 专属 API Key（2026-06-15 起；之前是 Coding Plan，已弃用）
- **API Key 格式**：`sk-sp-D.xxxxx`（带分隔点）+ `==` 结尾
- **OpenAI Base URL（当前）**：`https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1`
- **Anthropic Base URL（当前）**：`https://token-plan.cn-beijing.maas.aliyuncs.com/apps/anthropic`（**仅用于 Claude Code 等编程工具**；Token Plan 不支持 Claude 模型走这条）
- **官方模型 ID（Token Plan 实测可用，文本生成）**：
  - `qwen3.7-max`
  - `qwen3.7-plus`
  - `qwen3.6-plus`（支持图片理解）
  - `qwen3.6-flash`
  - `kimi-k2.5`（支持图片理解）
  - `kimi-k2.6`
  - `glm-5`
  - `glm-5.1`
  - `MiniMax-M2.5`
  - `deepseek-v3.2`
  - `deepseek-v4-flash`
  - `deepseek-v4-pro`
- **图像生成（独立接口，需通过 Skill / 扩展接入）**：
  - `qwen-image-2.0` / `qwen-image-2.0-pro`
  - `wan2.7-image` / `wan2.7-image-pro`
- **LiteLLM config 当前挂载的 Bailian model（2026-06-15 三轮后，12 个全绿）**：
  - `Bailian-qwen3.7-max` ✅
  - `Bailian-qwen3.7-plus` ✅
  - `Bailian-qwen3.6-plus` ✅
  - `Bailian-qwen3.6-flash` ✅
  - `Bailian-kimi-k2.5` ✅
  - `Bailian-kimi-k2.6` ✅
  - `Bailian-glm-5` ✅
  - `Bailian-glm-5.1` ✅
  - `Bailian-MiniMax-M2.5` ✅
  - `Bailian-deepseek-v3.2` ✅
  - `Bailian-deepseek-v4-flash` ✅
  - `Bailian-deepseek-v4-pro` ✅
- **已临时下架（不在 Token Plan 列表 / 原 Coding Plan 失效）**：
  - `Bailian-qwen3.5-plus`
  - `Bailian-qwen3-max-2026-01-23`
  - `Bailian-qwen3-coder-next`
  - `Bailian-qwen3-coder-plus`
  - `Bailian-glm-4.7`
- **多模态 / 图片理解**：
  - 明确支持图片理解的：`qwen3.6-plus`、`kimi-k2.5`
- **MCP / 工具接入**：
  - Token Plan 团队版**仅限 AI 编程工具和 OpenClaw 类型 Agent** 使用
  - 支持 Claude Code、Kilo Code、Qwen Code 插件接入 IDE
  - **不支持** Dify / n8n / Postman / 自定义后端脚本这类场景
- **重要约束**：
  - Token Plan Key 与百炼按量计费 Key **不互通**，不能混用
  - Token Plan Key 与 Coding Plan Key **不互通**，不能混用
  - 必须使用 `token-plan.cn-beijing.maas.aliyuncs.com`
  - 用错 Base URL 报 `401 Incorrect API key provided`
- **官方来源**：
  - `https://help.aliyun.com/zh/model-studio/token-plan-quickstart`
  - `https://help.aliyun.com/zh/model-studio/token-plan-faq`
  - `https://help.aliyun.com/zh/model-studio/more-tools`

---

## 3) 火山方舟 / Lite 40元/月

- **厂商简称**：Volcengine
- **凭证类型**：Ark Coding Plan API Key
- **API Key 获取页**：`https://console.volcengine.com/ark/region:ark+cn-beijing/apikey`
- **Base URL（Coding Plan 专用）**：`https://ark.cn-beijing.volces.com/api/coding/v3`
- **官方模型 ID（套餐支持）**：
  - `doubao-seed-2.0-code`
  - `doubao-seed-2.0-pro`
  - `doubao-seed-2.0-lite`
  - `doubao-seed-code`
  - `minimax-m2.5`
  - `glm-4.7`
  - `deepseek-v3.2`
  - `kimi-k2.5`
  - `ark-code-latest`
- **重要约束**：
  - `ark-code-latest` 是可切换档位的别名，真正模型在控制台里切换
  - 不要用在线推理的模型 ID（如 `*-260215` 这类）
  - 不要用 `https://ark.cn-beijing.volces.com/api/v3`
- **多模态 / 图片识别**：
  - 官方实践文档明确 Coding Plan 支持图像识别
- **MCP / 工具接入**：
  - 官方实践文档以 TRAE / OpenClaw / AI coding tool 场景讲解
  - 统一按 OpenAI 协议接入 Coding Plan
- **官方来源**：
  - `https://developer.volcengine.com/articles/7616625541761597476`
  - `https://www.volcengine.com/docs/82379/2183190?lang=zh`
  - `https://www.volcengine.com/docs/82379/2205646?lang=zh`

---

## 4) Agnes AI

- **厂商简称**：Agnes
- **凭证类型**：Agnes API Key
- **OpenAI Base URL（当前）**：`https://apihub.agnes-ai.com/v1`
- **官方模型 ID（本次已验证）**：
  - `agnes-2.0-flash`
  - `agnes-image-2.1-flash`
  - `agnes-video-v2.0`
- **当前 LiteLLM 实际注册**：
  - `Agnes-2.0-flash`
  - `Agnes-image-2.1-flash`
  - `Agnes-video-v2.0`
- **本次已移除 / 不注册**：
  - `Agnes-1.5-flash`（旧文本版本，按最小必要集合移除）
  - `Agnes-image-2.0-flash`（旧图像版本，保留 2.1）
  - `Agnes-video-v2.1`（上游未提供可用 channel）
- **多模态 / 特殊端点**：
  - 文本：`/v1/chat/completions`
  - 图像：`POST /v1/images/generations`
  - 视频：`POST /v1/videos`
- **重要约束**：
  - 图像 / 视频模型不能按 chat 路由注册，否则会返回 404
  - `Agnes-image-2.1-flash` 在 LiteLLM 下先用最小 payload，额外传 `response_format` 会触发 unsupported-param 校验
  - `Agnes-video-v2.0` 的 `seconds` 需要传字符串（如 `"5"`）
- **官方来源**：
  - `https://agnes-ai.com/doc`
  - `https://agnes-ai.com/doc/agnes-20-flash`
  - `https://agnes-ai.com/doc/agnes-image-21-flash`
  - `https://agnes-ai.com/doc/agnes-video-v20`

---

## 5) SenseNova / Free 0元/月

- **厂商简称**：SenseNova
- **凭证类型**：SenseNova API Key（`sk-...`）
- **Base URL**：`https://token.sensenova.cn/v1`
- **官方模型 ID（套餐支持）**：
  - `sensenova-6.7-flash-lite`
  - `sensenova-u1-fast`
  - `deepseek-v4-flash`
- **多模态 / 图片理解**：
  - `sensenova-6.7-flash-lite` 支持 `image_url` 图片输入块
  - `deepseek-v4-flash` 支持 thinking / non-thinking、tool calling、JSON 输出
- **特殊端点**：
  - `POST https://token.sensenova.cn/v1/images/generations`
  - 仅 `sensenova-u1-fast` 使用
- **MCP / 工具接入**：
  - 官方文档明确支持 tool calling / streaming
  - 目前未见独立外部 MCP server 配置说明，按 OpenAI-compatible 方式接入
- **官方来源**：
  - `https://platform.sensenova.cn/en/docs`

---

## 7) Gitcode / AtomGit Lite 0元/月（公测中）

- **厂商简称**：AtomGit（GitCode 域名上的官方 AI 社区 / AtomCode 生态）
- **凭证类型**：AtomGit OAuth / AtomGit AI Access Token
- **官方 / 运行时 Base URL**：
  - 官方社区 API 文档：`https://api-ai.gitcode.com/v1`
  - AtomCode 自动生成的 CodingPlan 运行时：`https://llm-api.atomgit.com/v1`
- **官方示例模型 ID**：
  - `deepseek-ai/DeepSeek-R1`（官方 API 文档示例）
- **AtomCode 自动写入的本地 provider 模型 ID**：
  - `deepseek-v4-flash`
  - `Qwen/Qwen3.6-35B-A3B`
  - `Qwen/Qwen3-VL-8B-Instruct`
- **多模态 / 图片**：
  - `Qwen/Qwen3-VL-8B-Instruct` 用作视觉/预处理 provider
  - AtomCode 配置中的 `vision_preprocessor_provider` 默认指向该模型
- **MCP / 工具接入**：
  - AtomCode 内置 MCP 客户端，自 v4.20.4 起支持 `.mcp.json`
  - 全局：`~/.atomcode/mcp.json`
  - 项目级：`<项目根>/.mcp.json`
  - 命令：`atomcode mcp add` / `atomcode mcp reload` / `atomcode mcp login github`
- **官方来源**：
  - `https://atomcode.atomgit.com/docs/index.html`
  - `https://atomcode.atomgit.com/docs/configuration.html`
  - `https://atomcode.atomgit.com/docs/login.html`
  - `https://atomcode.atomgit.com/docs/mcp.html`
  - `https://ai-docs.atomgit.com/docs/api/langchain`
  - `https://ai-docs.atomgit.com/docs/models/`

---

## 8) ChatGPT / OpenAI

- **厂商简称**：ChatGPT / OpenAI
- **凭证类型**：ChatGPT OAuth / Codex backend token
- **Base URL**：`https://chatgpt.com/backend-api/codex`
- **当前用途**：LiteLLM / Codex 兼容网关
- **备注**：如需恢复/更换官方 API Key，请把新的凭证名补进 `credentials/系统凭证备忘录.md`

---

## 9) 特殊调用条件总表

| 厂商 | 特殊条件 |
| --- | --- |
| MiniMax | Token Plan 走 Token Plan Key；Pay-as-you-go 走独立 API Key；Coding 工具优先用 Anthropic Base URL；不注册 Highspeed 变体。 |
| Bailian | 必须使用 `token-plan.cn-beijing.maas.aliyuncs.com`；Token Plan Key 与按量计费 Key / Coding Plan Key 不互通。 |
| Volcengine | 只能用 `https://ark.cn-beijing.volces.com/api/coding/v3`；`ark-code-latest` 是可切换档位别名。 |
| Agnes | 多模态必须分流：文本走 chat，图像走 `/v1/images/generations`，视频走 `/v1/videos`；`seconds` 传字符串。 |
| SenseNova | `sensenova-u1-fast` 的图片生成走 `POST https://token.sensenova.cn/v1/images/generations`，不是通用 chat endpoint。 |
| AtomGit | 官方社区文档与 AtomCode 自动生成运行时共存：`api-ai.gitcode.com/v1` 与 `llm-api.atomgit.com/v1` 分别用于不同入口；MCP 通过 AtomCode `.mcp.json` 管。 |

---

- LiteLLM 后续注册名将使用：**厂商前缀 + 官方模型 ID**
- LiteLLM 配置速查见：`AI-Center/credentials/LiteLLM-模型配置方法.md`
- 多模态模型、图片生成模型、MCP 工具，不和纯文本模型混在同一条逻辑里
- 只要官方页出现“专用 endpoint / 专用 base URL”，就单独记录，不复用通用接口
- 以后只做增量修补：
  - 新模型加入
  - 官方下线/弃用
  - endpoint 变更
  - 套餐支持范围变化
