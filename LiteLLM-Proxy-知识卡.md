# LiteLLM Proxy 知识卡

> 来源：LiteLLM 官方文档（docs.litellm.ai）与本机部署实测
> 
> 结论先行：**LiteLLM 的模型注册不是靠 OAuth**。最新官方文档显示，模型接入主要通过 **config.yaml**、Admin UI 的 **Store Model in DB**、以及管理 API **`/model/new`** 完成；OAuth 主要用于 **Admin UI SSO / Proxy JWT / MCP OAuth / ChatGPT Subscription** 这类鉴权场景。

## 1. LiteLLM 是什么
- 一个 **OpenAI-compatible 的 LLM Gateway / Proxy**。
- 目标不是“自己训练模型”，而是把多供应商、多模型统一成一个入口。
- 常见用途：统一 API、虚拟 Key、限额、模型路由、日志审计、Admin UI、MCP 网关。

## 2. 推荐安装方式
### 官方推荐形态
- **Docker / Docker Compose + Postgres** 是最稳的部署方式。
- 单纯 `pip install litellm` 更适合开发或 Python SDK，不适合作为长期网关主服务。

### 官方 quick start 的关键点
- 镜像：`docker.litellm.ai/berriai/litellm:main-stable`
- 配套：`docker-compose.yml`
- 配置文件：`config.yaml`
- 环境变量：`.env`
- 必需键：
  - `LITELLM_MASTER_KEY`：Proxy 管理/调用主 key
  - `LITELLM_SALT_KEY`：加密模型供应商凭据，**添加模型后不应随便改**

### 启动前最低检查
- `config.yaml` 是否挂载进容器
- `.env` 是否被 Compose 读取
- Postgres 是否健康
- 端口映射是否正确（本机 / 局域网）

## 3. 使用方式
### 基本调用
- Proxy 启动后，客户端按 OpenAI 格式调用：
  - `base_url = http://<proxy-host>:4000`
  - `api_key = <LITELLM_MASTER_KEY 或虚拟 key>`
- 常见验证路径：
  - `/health`
  - `/health/liveliness`
  - `/v1/models`
  - Admin UI `/ui/`

### 模型管理
- **查看模型信息**：`GET /model/info`
- **新增模型**：`POST /model/new`，无需重启即可加模型
- **配置来源**：`config.yaml` 的 `model_list`
- **UI 持久化模型**：`store_model_in_db` 开启后，模型定义可落库，UI 修改可覆盖文件配置
- **模型配置速查**：见 `AI-Center/credentials/LiteLLM-模型配置方法.md`

### 虚拟 Key / 权限控制
- `LITELLM_MASTER_KEY` 是管理员级入口，不等于普通用户 key
- 真实使用时通常给业务方发 **Virtual Key**
- 通过 `/key/generate` 创建虚拟 key
- 通过 `/key/info` 查看 key 信息
- Virtual Key 可以绑定允许访问的模型列表、RPM、预算等

## 4. 最容易出问题的地方
### 4.1 Docker 命令混淆
- 旧环境常见：`docker-compose`
- 新 CLI 才有：`docker compose`
- **不要凭感觉写**，先确认系统支持哪个命令

### 4.2 `health: starting` 不一定是挂了
- LiteLLM 启动时会跑迁移 / 校验
- 这段时间健康状态可能卡在 `starting`
- 先看日志再下结论，别手欠反复重启

### 4.3 `/v1/models` 空，不一定是模型不存在
优先排查：
1. `config.yaml` 是否真的加载
2. `model_list` 名称是否拼对
3. `.env` 里供应商 key 是否注入到容器
4. `LITELLM_SALT_KEY` 是否有效
5. DB 迁移是否完成

### 4.4 Admin UI 登录和 API Key 是两套东西
- UI 登录：`UI_USERNAME` / `UI_PASSWORD`
- API 管理：`LITELLM_MASTER_KEY`
- 数据库：Postgres 自己的账号密码
- 这三套东西不要混成一套

### 4.5 OAuth 不是“模型注册”
最新官方文档里，OAuth 主要出现于：
- **Admin UI SSO**：OIDC / OAuth 登录
- **Proxy JWT / OIDC Auth**：控制模型访问
- **MCP OAuth**：给 MCP 客户端做授权
- **ChatGPT Subscription models**：OAuth device flow 访问订阅模型

**结论：模型注册仍然靠 `config.yaml` / `/model/new` / UI 落库，不是靠 OAuth。**

### 4.6 只绑 127.0.0.1 会导致局域网访问不了
- 如果想给局域网其他机器访问，端口必须暴露到 `0.0.0.0`
- 但这意味着你要自己负责网络边界，不要把管理口裸奔到公网

### 4.7 模型命名要一致
- 上游供应商名、LiteLLM 别名、客户端调用名，经常不是同一个字符串
- 先统一命名，再谈路由
- 乱起名会导致 `/v1/models` 看起来“有”，但客户端调用“没有”

## 5. 选型建议
### 主力组合
- **GLM-4.7**：日常主力
- **GLM-5.1**：复杂工程 / 长任务旗舰
- **GLM-4.5-Air**：兜底备用

### 什么时候加别的
- 你明确依赖 OpenClaw 的长链路任务：再加 **GLM-5-Turbo**
- 需要视觉：看 **Vision Understanding MCP** 或独立视觉模型，不要硬塞进文本主模型列表

## 6. 本机已验证经验
- 推荐采用独立 Compose 项目目录
- Postgres 作为并列服务更稳
- `docker compose` 在本机不可用时，必须退回 `docker-compose`
- 服务启动成功的关键标志：
  - `Application startup complete.`
  - `/health/liveliness` 返回 `I'm alive!`
  - `/v1/models` 返回配置模型
  - Admin UI 可登录

## 7. 查询关键词
以后查这类问题，优先搜：
- `LiteLLM config.yaml model_list`
- `LiteLLM /model/new`
- `LiteLLM store_model_in_db`
- `LiteLLM virtual keys`
- `LiteLLM Admin UI SSO`
- `LiteLLM MCP OAuth`
- `LiteLLM docker compose postgres`
- `LiteLLM health liveliness`
