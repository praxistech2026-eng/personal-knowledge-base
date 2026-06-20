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

- **LiteLLM alias 规则**：`Agnes-<官方模型ID>`（待用户确认 model ID）
- **套餐**：官网注册（具体套餐未提供）
- **2026-06-20 注册**：用户提供
- **API Key**：`sk-ywTxfQifM12QQanVaZKq2vl3pgOzbVGRYTajKFdV7QxvL5ZP`（明码，按用户偏好）
- **base_url**：`https://apihub.agnes-ai.com/v1`
- **协议**：OpenAI 兼容（`/v1/chat/completions`）

### 2026-06-20 已知异常：DNS 路由失效

| 探测 | 结果 |
|------|------|
| `apihub.agnes-ai.com` DNS 解析 | `198.20.0.53`（Spectrum ISP 内网 IP，不是公网） |
| TCP 443 | ✅ 通（fake-IP 段，本机可见） |
| TLS 握手 | ❌ `SSL_ERROR_SYSCALL` |
| HTTPS `/v1/models` | ❌ 超时空响应 |
| NS 服务器 | `lady.ns.cloudflare.com` / `felicity.ns.cloudflare.com`（Cloudflare 托管） |

**初步判断**：Agnes AI 使用 Cloudflare Spectrum/Magic Transit 把请求路由到后端 Spectrum 客户的内网服务器；当前路由可能已下线（用户确认之前能浏览器访问，目前不能）。Cloudflare 边缘没动，是 Agnes AI 后端服务异常。

### 待办（用户验证后执行）

1. ⏸️ 用户在浏览器打开 https://apihub.agnes-ai.com/v1/models 验证
2. ⏸️ 如果浏览器能通但本机不通 —— 需要排查 fake-IP / 路由
3. ⏸️ 如果浏览器也不能通 —— Agnes AI 当前服务异常，等恢复后再注册
4. ⏸️ 用户提供具体 model ID 后再正式写入 LiteLLM config
