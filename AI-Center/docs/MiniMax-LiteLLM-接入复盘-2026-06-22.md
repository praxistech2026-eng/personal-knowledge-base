# MiniMax LiteLLM 接入复盘 — 2026-06-22

> 结论：MiniMax（中国区 Token Plan）已按当前结果正确接入 LiteLLM。当前可直接使用的注册面是 `MiniMax-M3`、`MiniMax-M2.7`、`MiniMax-speech-2.8-hd`、`MiniMax-speech-2.8-turbo`。

## 一句话结论

这次接入的正确做法不是“把 MiniMax 全家桶都塞进 `model_list`”，而是按 LiteLLM 的底座标准，只注册当前能稳定走通的文本 / 语音模型；图像、视频、音乐这类独立能力保留为桥接或待定，不拿单一厂商的能力表反过来改底座。

## 当前落地结果

### LiteLLM 运行态
- LiteLLM 容器已运行，数据库健康。
- `/v1/models` 能返回当前注册模型。
- `/v1/chat/completions` 对 `MiniMax-M3` 已验证可通。
- `speech` 模型已在前序探测中通过真实 `/v1/audio/speech` 验收，不再用 chat-style health 误判。

### 当前注册模型
- `MiniMax-M3`
- `MiniMax-M2.7`
- `MiniMax-speech-2.8-hd`
- `MiniMax-speech-2.8-turbo`

### 当前配置方式
- 走中国区入口。
- 使用 Token Plan Subscription Key。
- `api_base` 走 MiniMax CN 兼容口，不混用国际区结果。
- `model_list` 只保留 LiteLLM 已能稳定承载的能力面。

## 为什么这样接

### 1) LiteLLM 是底座，不是厂商能力清单
底座只接受可复用、可验证、可维护的能力。某个厂商额外提供了 image / video / music，不代表必须硬塞进 `model_list`。

### 2) 文本 / 语音和生成类能力要分层
- 文本 / 对话：可以直接注册到 `model_list`
- 语音 / TTS：可以直接注册，但验收必须打真实语音 endpoint
- 图像 / 视频 / 音乐：属于独立 endpoint 或桥接层，不按聊天模型那套处理

### 3) 不能用错误的 health 口径下结论
`/health/latest` 只是历史探测记录，不是最终事实。
语音能力如果拿 chat-style probe 看，容易出现假阴性。

### 4) 已注册厂商重跑必须做“新采集 vs 已注册”对比
这次 MiniMax 的处理方式不是复用旧结论，而是重新核对：
- 官方文档
- 真实 upstream 调用
- LiteLLM proxy 调用
- 当前 config 中已有模型

## 可复用经验

### 经验 1：先判定 surface，再决定 register / bridge / pending
不要先问“能不能加模型”，先问：
- 它是不是 `model_list` 能直接承载的能力
- 它是不是独立 endpoint
- 它是不是 MCP 工具
- 它是不是要等桥接器

### 经验 2：区域、Key 类型、套餐档位是前置条件
中国区 Token Plan、国际区、Coding Plan、Subscription Key 不是一回事。
拿错市场文档去套当前 key，结论会直接跑偏。

### 经验 3：语音能力要用语音接口验收
语音模型不能只看 chat 结果，更不能只看健康检查。
最终结论要以 `/v1/audio/speech` 的真实返回为准。

### 经验 4：生成类能力别硬拉进主模型表
图像 / 视频 / 音乐如果需要独立任务流或桥接器，就应单独归档，别污染文本模型的主路径。

### 经验 5：成功注册后要写迭代建议，但不能自动改 Skill
这次沉淀下来最有价值的不是“又加了几个模型”，而是把注册门槛、验证门槛、桥接边界和回写条件都固化了。

## 风险与未确认项

- 图像 / 视频 / 音乐能力在本工作区里保留为桥接优先或待定，不纳入当前 `model_list`。
- 如果后续出现多个厂商共享的同类生成接口，再考虑回写 LiteLLM 核心规则。
- 若 MiniMax 套餐或额度池变化，需要重新做 upstream + proxy 复核，不能只看历史记录。

## 关联文档

- `../platforms/minimax/README.md`
- `./MiniMax-TokenPlan-调研-2026-06-15.md`
- `./WIKI-索引.md`

## 迭代记录

- 2026-06-22：完成当前结果复盘，确认 LiteLLM 只保留文本 / 语音的稳定注册面，生成类能力不强塞进 `model_list`。
- 2026-06-15：完成早期 Token Plan 调研与探测。
