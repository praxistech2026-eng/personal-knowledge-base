# LLM 厂商配置基线

> 目标：只记录**你当前套餐实际支持的模型**、调用地址、特殊端点、工具/MCP 配置方式与验证日期。
> 统一规则：**厂商前缀 + 官方模型ID**。这里先存“官方原始模型ID”，后续由 LiteLLM 生成器拼装别名。
> 最后核验日期：2026-05-20

---

## 1) MiniMax / Starter 29元/月

- **厂商简称**：MiniMax
- **凭证类型**：Token Plan Key / API Key
- **OpenAI Base URL**：
  - 国际：`https://api.minimax.io/v1`
  - 中国：`https://api.minimaxi.com/v1`
- **Anthropic Base URL**：
  - 国际：`https://api.minimax.io/anthropic`
  - 中国：`https://api.minimaxi.com/anthropic`
- **官方模型 ID（文本，已用于 AI Coding 工具/Token Plan）**：
  - `MiniMax-M2.7`
  - `MiniMax-M2.5`
  - `MiniMax-M2.1`
  - `MiniMax-M2`
- **本套餐处理规则**：
  - **不注册任何 Highspeed 变体**
  - `M2.7` 是最明确的 AI Coding 主模型
- **多模态 / 工具**：
  - 官方文档覆盖 Text / Audio / Video / Music 全谱系
  - Token Plan quickstart 明确支持 AI Coding Tools、MCP Integration
- **MCP / 工具接入**：
  - 官方支持的工具页包含 Claude Code、Cursor、Trae、OpenCode、Kilo Code、Cline、Grok CLI、Codex CLI、Droid
  - 典型配置：设置 `ANTHROPIC_BASE_URL`，并把 `ANTHROPIC_MODEL` 指向 `MiniMax-M2.7`
- **官方来源**：
  - `https://platform.minimax.io/docs/guides/models-intro`
  - `https://platform.minimax.io/docs/guides/text-ai-coding-tools`
  - `https://platform.minimax.io/docs/token-plan/intro`
  - `https://platform.minimax.io/docs/guides/pricing-token-plan`
  - `https://platform.minimax.io/docs/token-plan/faq`

---

## 2) 阿里云百炼 / Pro 200元/月

- **厂商简称**：Bailian
- **凭证类型**：Coding Plan 专属 API Key
- **API Key 格式**：`sk-sp-xxxxx`
- **OpenAI Base URL**：`https://coding.dashscope.aliyuncs.com/v1`
- **Anthropic Base URL**：`https://coding.dashscope.aliyuncs.com/apps/anthropic`
- **官方模型 ID（套餐支持）**：
  - `qwen3.6-plus`（支持图片理解）
  - `kimi-k2.5`（支持图片理解）
  - `glm-5`
  - `MiniMax-M2.5`
  - `qwen3.5-plus`（支持图片理解）
  - `qwen3-max-2026-01-23`
  - `qwen3-coder-next`
  - `qwen3-coder-plus`
  - `glm-4.7`
- **多模态 / 图片理解**：
  - 明确支持图片理解的：`qwen3.6-plus`、`kimi-k2.5`、`qwen3.5-plus`
- **MCP / 工具接入**：
  - 文档明确支持 AI 编程工具和 OpenClaw 类型 Agent
  - 支持通过 Claude Code、Kilo Code、Qwen Code 插件接入 IDE
  - 不支持 Dify / n8n / Postman / 自定义后端脚本这类场景
- **重要约束**：
  - Coding Plan Key 与百炼按量计费 Key **不互通**，不能混用
  - 必须使用 `coding.dashscope.aliyuncs.com`
- **官方来源**：
  - `https://help.aliyun.com/zh/model-studio/coding-plan`
  - `https://help.aliyun.com/zh/model-studio/more-tools`
  - `https://help.aliyun.com/zh/model-studio/claude-code`
  - `https://help.aliyun.com/zh/model-studio/qwen-code`
  - `https://help.aliyun.com/zh/model-studio/kilo-cli`

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

## 4) Z.AI / GLM Max 469元/月

- **厂商简称**：ZAI
- **凭证类型**：Z.AI API Key
- **General Base URL**：`https://api.z.ai/api/paas/v4`
- **Coding Base URL**：`https://api.z.ai/api/coding/paas/v4`
- **Anthropic Base URL**：`https://api.z.ai/api/anthropic`
- **官方模型 ID（Coding Plan 支持）**：
  - `glm-5.1`
  - `glm-5-Turbo`
  - `glm-4.7`
  - `glm-4.5-Air`
- **多模态 / 能力**：
  - 官方 Coding Plan 文档提供 Vision Understanding
  - 还有 Web Search / Web Reader / Zread MCP
- **MCP / 工具接入**：
  - 官方 Coding Plan 专属 MCP：Vision Understanding、Web Search、Web Reader、Zread
  - 适用工具：Claude Code、Cline、OpenCode、Crush、Roo Code、Kilo Code、Goose 等
  - 使用 Coding Plan 时，必须改用 Coding Endpoint 而不是 General API
- **官方来源**：
  - `https://docs.z.ai/devpack/overview`
  - `https://docs.z.ai/devpack/quick-start`
  - `https://docs.z.ai/devpack/tool/others`
  - `https://docs.z.ai/api-reference/introduction`
  - `https://docs.z.ai/api-reference/llm/chat-completion`
  - `https://docs.z.ai/devpack/using5.1`
  - `https://docs.z.ai/scenario-example/develop-tools/claude`

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

## 6) DeepSeek / 无套餐 API 接入

- **厂商简称**：DeepSeek
- **凭证类型**：DeepSeek API Key
- **Base URL（OpenAI）**：`https://api.deepseek.com`
- **Base URL（Anthropic）**：`https://api.deepseek.com/anthropic`
- **官方模型 ID（当前可用）**：
  - `deepseek-v4-flash`
  - `deepseek-v4-pro`
- **兼容别名（官方标注将弃用）**：
  - `deepseek-chat`（将于 2026/07/24 弃用）
  - `deepseek-reasoner`（将于 2026/07/24 弃用）
- **多模态 / 工具**：
  - 官方文档明确可用于 Claude Code、GitHub Copilot、OpenCode 等 coding agent
  - 以 OpenAI / Anthropic 兼容格式接入
- **策略**：
  - 当前 API 已失效，先保留占位
  - 等你给新 Key 再启用
- **官方来源**：
  - `https://platform.deepseek.com/api-docs/models`

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

## 8) 特殊调用条件总表

| 厂商 | 特殊条件 |
| --- | --- |
| MiniMax | Token Plan 走 Token Plan Key；Pay-as-you-go 走独立 API Key；Coding 工具优先用 Anthropic Base URL；不注册 Highspeed 变体。 |
| Bailian | 必须使用 `coding.dashscope.aliyuncs.com`；Coding Plan Key 与按量计费 Key 不互通。 |
| Volcengine | 只能用 `https://ark.cn-beijing.volces.com/api/coding/v3`；`ark-code-latest` 是可切换档位别名。 |
| ZAI | GLM Coding Plan 必须使用 `https://api.z.ai/api/coding/paas/v4`；General API 与 Coding API 分离；Coding Plan 还内置专属 MCP 工具。 |
| SenseNova | `sensenova-u1-fast` 的图片生成走 `POST https://token.sensenova.cn/v1/images/generations`，不是通用 chat endpoint。 |
| DeepSeek | 当前 API 已失效，先占位；将来新 Key 到位后再启用。 |
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
