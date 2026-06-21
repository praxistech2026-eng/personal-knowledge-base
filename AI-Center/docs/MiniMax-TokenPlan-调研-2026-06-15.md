# MiniMax（中国）Token Plan 调研 — 2026-06-15

> 用户任务：把 Token Plan key 接到 LiteLLM，**把支持的模型都加上**。
> 实操时间：2026-06-15
> 实机探测脚本：`/tmp/probe-minimax.py`（一次性，**不写新 key 到磁盘**）

---

## 1. 2026 年 plan 变化要点（来自官方文档）

1. **MiniMax-M3 已发布**：1M 上下文、多模态、agent 推理，比 M2.7 更大
2. **Token Plan 切到 Token-Based 计量**：不再"次调用"，按实际 token 用量扣额度
3. **M2.7 老用户权益保留**（2026-06-05 前已订阅用户）：M2.7 5 小时使用次数 +10%，M3 与 M2.7 共享额度池
4. **M2.7-highspeed / M2.5-highspeed** 是同模型的快速档（不同 RPM/限速）
5. **国内 / 国际端点分离**：
   - 国内 OpenAI 兼容：`https://api.minimaxi.com/v1`
   - 国内 Anthropic 兼容：`https://api.minimaxi.com/anthropic`
   - 国际 OpenAI 兼容：`https://api.minimax.io/v1`
   - 国际 Anthropic 兼容：`https://api.minimax.io/anthropic`
6. **OpenClaw 接入示例**：配 `api.minimaxi.com/anthropic` + 订阅 Key

官方文档：
- `https://platform.minimaxi.com/docs/token-plan/intro`
- `https://platform.minimaxi.com/docs/token-plan/quickstart`
- `https://platform.minimaxi.com/docs/token-plan/other-tools`
- `https://platform.minimaxi.com/docs/token-plan/migration`

---

## 2. 实机核验（用新 Token Plan key）

新 key = 用户在对话里贴的明文（11 字符前缀 `sk-cp-...`，完整 125 字符）。脚本用命令行参数传入，**不写盘**。

### 2.1 `/v1/models` 列出 8 个 model

```
- MiniMax-M3                owned_by=minimax
- MiniMax-M2.7              owned_by=minimax
- MiniMax-M2.7-highspeed    owned_by=minimax
- MiniMax-M2.5              owned_by=minimax
- MiniMax-M2.5-highspeed    owned_by=minimax
- MiniMax-M2.1              owned_by=minimax
- MiniMax-M2.1-highspeed    owned_by=minimax
- MiniMax-M2                owned_by=minimax
```

### 2.2 OpenAI 兼容 chat 实测（`/v1/chat/completions`）

| Model | HTTP | 延迟 | 备注 |
|-------|------|------|------|
| MiniMax-M2.7 | 200 | 2610ms | 默认档 |
| MiniMax-M2.7-highspeed | 200 | 1009ms | 快速档，**推荐默认** |
| MiniMax-M2.5 | 200 | 1469ms | 上一代 |
| MiniMax-M2.5-highspeed | 200 | 1580ms | 上一代快速档 |
| MiniMax-M3 | 200 | 1620ms | 新一代 Frontier |
| MiniMax-Text-01 | 200 | 870ms | 多模态 Text 01 |

### 2.3 Anthropic 兼容端点实测（`/anthropic/v1/messages`）

| Model | HTTP | 延迟 |
|-------|------|------|
| MiniMax-M3 | 200 | 2639ms |
| MiniMax-M2.7 | 200 | 1459ms |
| MiniMax-M2.5 | 200 | 19490ms ⚠️ |
| MiniMax-Text-01 | 200 | 809ms |

### 2.4 Token Plan 订阅余量

`GET /v1/token_plan/remains` → 200，订阅有效，当前 5 小时窗口已用 0 / 总量 1000，剩余 3572962 毫秒。

---

## 3. 旧 key 失败原因

- 之前 LiteLLM 挂的 `MINIMAX_CN_API_KEY=sk-cp-...VpGQ`（13 字符）401
- 现在的 key 是完整 125 字符 `sk-cp-...wns=`（带分组 base64 编码 + 结尾 `=`）
- 旧 key 是早期 Coding Plan key，与 Token Plan **不互通**——和阿里百炼一样

---

## 4. 接入 LiteLLM 的具体方案

### 4.1 `.env` 改动

```bash
MINIMAX_CN_API_KEY=<新 Token Plan key，125 字符>
# 不变
MINIMAX_CN_API_HOST=https://api.minimaxi.com
```

### 4.2 `config.yaml` 新增 8 个 model

- `MiniMax-M3`
- `MiniMax-M2.7`
- `MiniMax-M2.7-highspeed`
- `MiniMax-M2.5`
- `MiniMax-M2.5-highspeed`
- `MiniMax-M2.1`
- `MiniMax-M2.1-highspeed`
- `MiniMax-M2`

OpenAI 兼容：`api_base: https://api.minimaxi.com/v1`

### 4.3 容器重建

`docker compose restart` **不会重读 env_file**，必须 `docker rm -f litellm && docker run ...`（之前踩过的坑）。

### 4.4 操作风险与缓解

- 新 key 是**明文**贴出的，会写进 `~/.hermes/.env` 和 `litellm/.env`（两处一致）
- `.env` 文件权限应保持 600（已是）
- 操作前备份 `.env` 和 `config.yaml`（之前 `config.yaml.bak-*` 已留 4 个备份）

---

## 5. 待办

- [ ] 用户确认后写 key 到 `.env`（两处：`~/.hermes/.env` 和 `/home/shin/workspace/litellm/.env`）
- [ ] 改 `config.yaml`：注释旧 `MiniMax-M2.7`（`api.minimaxi.com` 老 key 路径），新增 8 个 Token Plan model
- [ ] 重建容器
- [ ] 跑 `/health` 拉新快照
- [ ] 同步档案库：`docs/LiteLLM-健康快照-2026-06-15.md`、`credentials/LLM-厂商配置基线.md`、`docs/AI-Center-档案库整理计划.md`

---

## 6. 2026-06-20 回填：最终落地结论

- 官方文档确认 MiniMax CN Token Plan 支持的模型范围比最终落地更大，但 **当前 LiteLLM 只注册两个模型**：
  - `MiniMax-M3`
  - `MiniMax-M2.7`
- 本工作区最终采用 **OpenAI-compatible** 路线：`https://api.minimaxi.com/v1`
- `MINIMAX_CN_API_HOST` 必须带完整 `/v1`
- `MINIMAX_CN_API_KEY` 必须是 Token Plan Subscription Key
- `.env` 改动后必须用 `docker compose up -d --force-recreate` 让容器真正吃到新环境变量
- 当前验证通过：
  - `GET /health/liveliness` → 200
  - `GET /models` → 暴露 `MiniMax-M3` 和 `MiniMax-M2.7`
  - `POST /v1/chat/completions` → 两个模型都返回 200
- 对这套工作区来说，**M3 + M2.7 已经够用**：M3 做主力，M2.7 做稳定兜底
- 这份调研里早期的“全量 8 模型注册计划”保留为历史方案，不再作为当前落地方案
