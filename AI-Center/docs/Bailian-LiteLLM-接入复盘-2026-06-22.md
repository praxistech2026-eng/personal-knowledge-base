# 阿里百炼 LiteLLM 接入复盘 — 2026-06-22

> 结论：阿里百炼当前按 **Token Plan 团队版** 接入 LiteLLM，主链路已收口。当前注册面只保留经过白名单、价格和能力筛选后仍值得保留的文本模型；独立生成能力与未进入白名单的候选模型，统一留在 bridge / pending 区。

## 结论先行

这次接入的核心不是“把所有百炼能力都塞进 LiteLLM”，而是只接入当前档位可直接稳定承载、且经过筛选后值得保留的模型面；独立能力面留在 bridge / pending 区。

### 当前生效的关键信息
- region：CN / 北京
- key type：Token Plan 团队版 API Key
- base URL：`https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1`
- 计划档位：Token Plan 团队版
- 当前 LiteLLM 百炼注册面（active）：
  - `Bailian-qwen3.7-max`
  - `Bailian-qwen3.7-plus`
  - `Bailian-qwen3.6-flash`
  - `Bailian-kimi-k2.6`
  - `Bailian-glm-5.2`
  - `Bailian-MiniMax-M2.5`
  - `Bailian-deepseek-v4-flash`
  - `Bailian-deepseek-v4-pro`

## Phase 1: Research Intake

### 已核实
- region：CN
- key type：Token Plan 团队版 API Key
- plan tier：Token Plan 团队版
- base URL：`https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1`
- endpoint family：文本 / 对话

### 已观察到的上游能力
上游 `/models` 与官方文档里能看到的百炼相关能力面包括：
- 文本/对话：`qwen3.7-max`、`qwen3.7-plus`、`qwen3.6-flash`、`kimi-k2.6`、`deepseek-v4-pro`、`deepseek-v4-flash`、`deepseek-v3.2`、`glm-5.2`
- 图像生成：`qwen-image-2.0`、`qwen-image-2.0-pro`、`wan2.7-image`、`wan2.7-image-pro`
- 额外候选：Kimi 官方文档存在 `kimi-k2.7-code`，但它**不在 Token Plan 团队版支持白名单**里

### 归类原则
- 文本 / 对话：可直接注册
- 图像 / 视频 / 音乐：当前不进主 `model_list`，先留 bridge / pending
- MCP：本次不纳入主注册面，待后续按工具层单独归档
- `Kimi` 官方文档出现某模型，不代表 `Token Plan` 白名单支持；**白名单未列出的型号一律不进主池**

## Phase 2: Registration Draft

### 已落地动作
- 保留当前百炼文本注册面中的高价值模型
- 删除 `config.yaml` 里重复或低价值的百炼 active block，避免同名重复和阅读噪音
- 维持统一命名：`Bailian-<官方模型ID>`

### 当前配置状态
- 代理侧 `/v1/models`：当前为 8 个百炼 active 条目
- 百炼相关条目：8 个保留模型
- 代理侧聊天验证：
  - `Bailian-qwen3.7-plus` → `200`
  - `Bailian-glm-5.2` → `200`
  - `Bailian-deepseek-v4-pro` → `200`

### 已移除 / 不纳入主池
- `Bailian-qwen3.6-plus`：已移除，原因是同池同能力面下，`qwen3.7-plus` 更值得保留
- `Bailian-qwen3.5-plus`
- `Bailian-qwen3-max-2026-01-23`
- `Bailian-qwen3-coder-next`
- `Bailian-qwen3-coder-plus`
- `Bailian-glm-4.7`
- `kimi-k2.7-code`：**pending / unsupported**，因为不在 Token Plan 白名单

## Validation Gate

### 上游验证
- `GET /models`：通过
- `POST /chat/completions`：通过

### LiteLLM 代理验证
- `GET /v1/models`：通过
- `POST /v1/chat/completions`：通过

### 结论
- 当前百炼文本链路已可用
- 代理侧配置已收口
- 图像 / 视频 / 音乐能力不强塞入主链路，继续按 bridge-first 处理
- `kimi-k2.7-code` 不在当前 Token Plan 主池，不能因为 Kimi 官方文档存在就直接注册

## 未验证项
- 图像生成是否需要单独 bridge 注册
- 视频生成是否存在可复用 bridge
- 音乐生成是否具备 LiteLLM 可承载的稳定注册面
- MCP 工具层是否要纳入当前百炼档位

## 下一步
1. 若要继续扩展百炼能力面，先单独调研图像 / 视频 / 音乐的桥接器
2. 若只需要文本主链路，当前状态可直接沿用
3. 任何新能力先记入 archive，再决定是否进入 LiteLLM 主 `model_list`

## 经验回收
- 先确认当前档位，再看文档，不要用别的地区或别的套餐口径代替当前对象
- 不要把 `Kimi` 官方模型存在，错误理解成 Token Plan 白名单支持
- 不要把重复历史块留在 `config.yaml`，会让代理模型表和维护成本一起膨胀
- 文本已通时，优先保留可用最小集合；不要为了“完整”牺牲稳定性
