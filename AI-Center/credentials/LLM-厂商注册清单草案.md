# LLM 厂商注册清单草案

> 来源：`LLM-厂商配置基线.md`
> 目的：把"厂商前缀 + 官方模型ID"映射成 LiteLLM 可注册清单。
> 说明：本草案先保留官方模型 ID 的原始写法；正式写入 LiteLLM 前再做一次终审。

> **2026-06-15 状态**：本草案已**被实际 LiteLLM config 替代**。当前实挂在 LiteLLM 上的 24 个 model 详见：
> - `docs/LiteLLM-健康快照-2026-06-15.md`（健康状态 + API base）
> - `credentials/LLM-厂商配置基线.md`（每厂商当前挂载清单）
> - `/home/shin/workspace/litellm/config.yaml`（机器实跑）
>
> 下文保留作为"已审过的厂商 ID 候选池"，**不再作为 LiteLLM 注册依据**。

---

## 1) MiniMax

- **LiteLLM alias 规则**：`MiniMax-<官方模型ID>`
- **套餐**：Starter 29元/月
- **建议注册**：
  - `MiniMax-MiniMax-M2.7`
  - `MiniMax-MiniMax-M2.5`
  - `MiniMax-MiniMax-M2.1`
  - `MiniMax-MiniMax-M2`
- **不注册**：
  - 所有 Highspeed 变体

---

## 2) Bailian

- **LiteLLM alias 规则**：`Bailian-<官方模型ID>`
- **套餐**：阿里云百炼 Pro 200元/月
- **建议注册**：
  - `Bailian-qwen3.6-plus`
  - `Bailian-kimi-k2.5`
  - `Bailian-glm-5`
  - `Bailian-MiniMax-M2.5`
  - `Bailian-qwen3.5-plus`
  - `Bailian-qwen3-max-2026-01-23`
  - `Bailian-qwen3-coder-next`
  - `Bailian-qwen3-coder-plus`
  - `Bailian-glm-4.7`

---

## 3) Volcengine

- **LiteLLM alias 规则**：`Volcengine-<官方模型ID>`
- **套餐**：火山方舟 Lite 40元/月
- **建议注册**：
  - `Volcengine-doubao-seed-2.0-code`
  - `Volcengine-doubao-seed-2.0-pro`
  - `Volcengine-doubao-seed-2.0-lite`
  - `Volcengine-doubao-seed-code`
  - `Volcengine-minimax-m2.5`
  - `Volcengine-glm-4.7`
  - `Volcengine-deepseek-v3.2`
  - `Volcengine-kimi-k2.5`
  - `Volcengine-ark-code-latest`

---

## 5) SenseNova

- **LiteLLM alias 规则**：`SenseNova-<官方模型ID>`
- **套餐**：Free 0元/月
- **建议注册**：
  - `SenseNova-sensenova-6.7-flash-lite`
  - `SenseNova-sensenova-u1-fast`
  - `SenseNova-deepseek-v4-flash`

---

## 7) AtomGit / GitCode

- **LiteLLM alias 规则**：`AtomGit-<官方模型ID>`
- **套餐**：Lite 0元/月（公测中）
- **建议注册**：
  - `AtomGit-deepseek-v4-flash`
  - `AtomGit-Qwen/Qwen3.6-35B-A3B`
  - `AtomGit-Qwen/Qwen3-VL-8B-Instruct`

---

## 备注

- 如果你后续要求"LiteLLM alias 也必须完全避免斜杠"，则 `AtomGit-Qwen/Qwen3.6-35B-A3B` 这类名称需要再做一次最小化转写，但**官方模型 ID**本身仍保留原样。
- 这个草案暂时只做注册候选，不改正式 `config.yaml`。

---

## N) Agnes AI（Hub：apihub.agnes-ai.com）

- **LiteLLM alias 规则**：`Agnes-<官方模型ID>`
- **套餐**：官网注册（具体套餐未提供）
- **2026-06-20 注册**：用户提供
- **API Key**：`sk-ywT...L5ZP`（明码，按用户偏好）
- **base_url**：`https://apihub.agnes-ai.com/v1`
- **协议**：OpenAI 兼容（`/v1/chat/completions`）

### 2026-06-20 验证情况

- 域名 DNS 解析到 Spectrum ISP 段（198.20.0.x），**依赖后端 Spectrum 客户 IP 路由**——不同时刻可能漂移到不同 IP（198.20.0.53 失败过，198.20.0.70 当前可用）。已通过 `curl --resolve` 强制走 198.20.0.70 验证通过，返回 model 列表。
- 用户手机 4G 网络能访问（手机走运营商 DNS 可能解析到不同/可用的 IP）

### 注册 model 列表（全部 5 个，含多模态）

| LiteLLM alias | 原始 model_id | 类型 |
|---|---|---|
| `Agnes-1.5-flash` | `agnes-1.5-flash` | chat (text) |
| `Agnes-2.0-flash` | `agnes-2.0-flash` | chat (text) |
| `Agnes-video-v2.0` | `agnes-video-v2.0` | video (text+image) |
| `Agnes-image-2.0-flash` | `agnes-image-2.0-flash` | image (text+image) |
| `Agnes-image-2.1-flash` | `agnes-image-2.1-flash` | image (text+image) |

### 已注册位置

- **LiteLLM**：`~/workspace/litellm/config.yaml`（5 个 model_name 块，env 变量 `AGNES_CODING_API_KEY`）
- **LiteLLM .env**：`~/workspace/litellm/.env`（`AGNES_CODING_API_KEY=sk-ywTx...L5ZP`）
- **Hermes**：`~/.hermes/config.yaml` providers 段（`agnes` provider）+ quick_commands.models 5 个 alias + `~/.hermes/.env`（`AGNES_CODING_API_KEY`）
- **OpenClaw**：`~/.openclaw/agents/main/agent/plugins/agnes/catalog.json`（plugin 形式，5 个 model + apiKey 内嵌）

### 使用注意

- 域名 `apihub.agnes-ai.com` DNS 不稳定，IP 在 198.20.0.x 段漂移。**每次大调用前先 `dig +short apihub.agnes-ai.com` 验证当前 IP 可达**。
- 已知异常：第一次探测解析到 198.20.0.53 时 TLS 失败（IP 已下线/被回收）；现在 198.20.0.70 工作。
