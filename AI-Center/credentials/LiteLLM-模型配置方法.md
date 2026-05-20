# LiteLLM 模型配置方法速查

> 最后核验：2026-05-21
>
> 目标：把 LiteLLM 的**模型定义方式、动态增删方式、DB/UI 行为、路由/回退方式**一次说清。
>
> 统一前提：LiteLLM 的正式模型命名，按本环境约定使用 **`厂商前缀-官方模型ID`**。官方模型 ID 本身不改写，只在 LiteLLM 层加厂商前缀做别名。

---

## 1. LiteLLM 里“模型”到底从哪来

LiteLLM 支持三条主线：

1. **静态配置文件 `config.yaml`**
   - 通过 `model_list` 定义模型
   - 适合稳定、可版本管理的生产配置

2. **数据库存储模型定义**
   - 通过 `general_settings.store_model_in_db: true`
   - 或在 Admin UI 里切换 Store Model in DB
   - 适合需要在 UI 里动态增删模型的场景

3. **运行时 API / UI 新增模型**
   - `POST /model/new`：动态新增模型，**官方文档标注为 beta**
   - Admin UI 的 **Models + Endpoints** 页面也可以新增/编辑

结论很直接：
- **想要稳定、可审查、可回滚** → 静态 `config.yaml`
- **想要 UI 直接改、无需重启** → 开启 `store_model_in_db`
- **想临时补一个模型** → 用 UI 或 `POST /model/new`

---

## 2. 最核心的字段含义

### `model_name`
- 面向客户端的**公开模型名**
- 也是 LiteLLM 的**模型组 / model group** 名称
- 这个名字才是外部调用时写在 `model` 里的值

### `litellm_params.model`
- 传给 LiteLLM 内部路由器 / completion 的真实模型标识
- 常见形式：
  - `openai/gpt-4o`
  - `azure/gpt-4o-eu`
  - `bedrock/anthropic.claude-instant-v1`
  - `openai/facebook/opt-125m`（OpenAI-compatible 本地或代理接口）

### `api_base`
- 模型提供方的实际请求地址
- 对 OpenAI-compatible、Azure、Anthropic 兼容层、私有代理都很关键

### `api_key`
- 支持直接写值，也支持环境变量引用
- 推荐写法：`os.environ/ENV_VAR_NAME`

### `model_info`
- 给模型补充元数据
- 可放描述、版本、标签、额外属性
- **不影响调用本身**，但 `/model/info` 会返回这些信息

---

## 3. 静态配置的标准写法

```yaml
general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
  store_model_in_db: false

model_list:
  - model_name: <公开别名>
    litellm_params:
      model: <内部真实模型>
      api_base: os.environ/<BASE_URL_ENV>
      api_key: os.environ/<API_KEY_ENV>
      rpm: 60
    model_info:
      description: <可选说明>
      version: 1
```

### 规则
- `model_name` 是**用户看到的名字**
- `litellm_params.model` 是**LiteLLM 真正执行的模型字符串**
- `api_base` / `api_key` 通常放 `.env`
- `model_info` 只做描述和检索，不承担路由职责

---

## 4. 一个模型组挂多个部署

LiteLLM 支持把多个部署挂到同一个 `model_name` 下。

```yaml
model_list:
  - model_name: gpt-4o
    litellm_params:
      model: azure/gpt-4o-eu
      api_base: https://example-eu.openai.azure.com/
      api_key: os.environ/AZURE_API_KEY_EU
      rpm: 6

  - model_name: gpt-4o
    litellm_params:
      model: azure/gpt-4o-ca
      api_base: https://example-ca.openai.azure.com/
      api_key: os.environ/AZURE_API_KEY_CA
      rpm: 6
```

这意味着：
- 外部都调用 `model: gpt-4o`
- LiteLLM 在这两个部署之间做**负载均衡**
- 这不是“两个模型名”，而是**同一模型组的两个部署**

这才是 LiteLLM 最实用的玩法。

---

## 5. 默认模型 / 通配模型

官方文档支持 `model_name: "*"` 这种默认兜底写法。

适合场景：
- 想把某个 provider 的默认能力作为兜底
- 允许客户端直接请求未显式注册的模型名
- 你已经把 provider 凭证放进 `.env`

但这类配置要谨慎：
- 容易把不该暴露的模型也放出来
- 适合“平台型”部署，不适合严格白名单场景

---

## 6. 动态增删模型：UI / API / DB

### 6.1 Admin UI
路径：
- `http://<host>:4000/ui`
- 进入 **Models + Endpoints**
- 可以新增、编辑、查看模型

### 6.2 `store_model_in_db`

```yaml
general_settings:
  store_model_in_db: true
```

意义：
- 模型定义存进 DB
- UI 修改可直接生效
- 通常不需要重启 proxy

**关键点：UI 的设置会覆盖 config 文件。**

### 6.3 `POST /model/new`

官方提供 beta 接口，可以在不重启的情况下新增模型。

示例结构：

```json
{
  "model_name": "azure-gpt-turbo",
  "litellm_params": {
    "model": "azure/gpt-3.5-turbo",
    "api_base": "https://example.openai.azure.com/",
    "api_key": "os.environ/AZURE_API_KEY"
  }
}
```

### 6.4 `GET /model/info`

用途：
- 查看模型元信息
- 确认 `model_info`
- 查看 LiteLLM 合并后的模型信息

注意：
- API key 不会回传
- 文档把它当成 model management 的一部分

---

## 7. 路由、回退、负载均衡

LiteLLM 不只是“模型注册表”，它也是一个路由层。

### 常见配置层
- `router_settings`
  - 做负载均衡、路由策略
- `litellm_settings.fallbacks`
  - 模型组 fallback
- `litellm_settings.default_fallbacks`
  - 通用兜底
- `context_window_fallbacks`
  - 上下文超限时切换
- `content_policy_fallbacks`
  - 内容策略触发时切换

### 实操建议
- 同一业务模型做多部署时，优先挂到同一个 `model_name`
- 需要灾备时再加 fallback
- 不要一上来就把 fallback 逻辑写得很复杂，先把主链路跑通

---

## 8. 环境变量和 provider prefix

### 环境变量引用
推荐统一写法：

```yaml
api_key: os.environ/OPENAI_API_KEY
api_base: os.environ/OPENAI_BASE_URL
```

### provider prefix
真实模型字符串里，LiteLLM 很多时候依赖 provider prefix：
- `openai/...`
- `azure/...`
- `bedrock/...`
- 其他兼容层按官方约定前缀写

如果是 OpenAI-compatible endpoint，前缀和 `api_base` 必须一起对上。

---

## 9. 本机实测验证顺序

调完模型后，按这个顺序验：

1. **容器起没起**
   - `docker compose ps`

2. **健康检查**
   - `GET /health/liveliness`

3. **模型列表**
   - `GET /v1/models`
   - 必须带 master key 或有效 virtual key

4. **模型信息**
   - `GET /model/info`

5. **UI**
   - 登录后看 Models + Endpoints

6. **日志**
   - 看是否出现：
     - `LiteLLM: Proxy initialized with Config, Set models:`
     - `prisma migrate deploy completed`

---

## 10. 这套环境的本地约定

### 命名规则
- LiteLLM 注册名统一用：**`厂商前缀-官方模型ID`**
- 官方模型 ID 保持原样，不做二次改写

### 基线优先级
配置前先看：
1. `AI-Center/credentials/LLM-厂商配置基线.md`
2. 本文 `LiteLLM-模型配置方法.md`
3. 再改 `config.yaml` 或 UI

### 不要做的事
- 不要把真实 key / 密码写进 Git
- 不要混用旧 key 和新初始化的 DB
- 不要把“模型别名”与“模型部署”混为一谈

---

## 11. 最短可用模板

### 模板 A：单模型、静态配置

```yaml
model_list:
  - model_name: SenseNova-deepseek-v4-flash
    litellm_params:
      model: openai/deepseek-v4-flash
      api_base: os.environ/SENSENOVA_BASE_URL
      api_key: os.environ/SENSENOVA_API_KEY
```

### 模板 B：同一模型组多个部署

```yaml
model_list:
  - model_name: gpt-4o
    litellm_params:
      model: azure/gpt-4o-eu
      api_base: os.environ/AZURE_EU_BASE_URL
      api_key: os.environ/AZURE_EU_API_KEY

  - model_name: gpt-4o
    litellm_params:
      model: azure/gpt-4o-ca
      api_base: os.environ/AZURE_CA_BASE_URL
      api_key: os.environ/AZURE_CA_API_KEY
```

### 模板 C：DB / UI 管理

```yaml
general_settings:
  store_model_in_db: true
```

然后：
- 用 UI 新增模型
- 或调用 `/model/new`

---

## 12. 结论

LiteLLM 的模型配置核心就三句话：

- **`model_name` 是外部看到的模型组名**
- **`litellm_params.model` 是内部真实模型路径**
- **`store_model_in_db` 决定你是靠 YAML 还是靠 DB/UI 管模型**

如果你以后让我“配置 LiteLLM 模型”，我会先按这份速查走：
1. 先确定模型来源是静态 YAML 还是 DB/UI
2. 再按厂商基线把官方模型 ID 变成 `厂商前缀-官方模型ID`
3. 最后做 `/v1/models`、`/model/info`、UI 三重验证
