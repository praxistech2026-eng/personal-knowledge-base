# LLM 厂商注册清单草案

> 来源：`LLM-厂商配置基线.md`
> 目的：把“厂商前缀 + 官方模型ID”映射成 LiteLLM 可注册清单。
> 说明：本草案先保留官方模型 ID 的原始写法；正式写入 LiteLLM 前再做一次终审。

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

## 4) ZAI

- **LiteLLM alias 规则**：`ZAI-<官方模型ID>`
- **套餐**：GLM Max 469元/月
- **建议注册**：
  - `ZAI-glm-5.1`
  - `ZAI-glm-5-Turbo`
  - `ZAI-glm-4.7`
  - `ZAI-glm-4.5-Air`

---

## 5) SenseNova

- **LiteLLM alias 规则**：`SenseNova-<官方模型ID>`
- **套餐**：Free 0元/月
- **建议注册**：
  - `SenseNova-sensenova-6.7-flash-lite`
  - `SenseNova-sensenova-u1-fast`
  - `SenseNova-deepseek-v4-flash`

---

## 6) DeepSeek

- **LiteLLM alias 规则**：`DeepSeek-<官方模型ID>`
- **套餐**：无套餐 API 接入（先占位）
- **建议注册**：
  - `DeepSeek-deepseek-v4-flash`
  - `DeepSeek-deepseek-v4-pro`

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

- 如果你后续要求“LiteLLM alias 也必须完全避免斜杠”，则 `AtomGit-Qwen/Qwen3.6-35B-A3B` 这类名称需要再做一次最小化转写，但**官方模型 ID**本身仍保留原样。
- 这个草案暂时只做注册候选，不改正式 `config.yaml`。
