# Hindsight

> AI Center 的长期记忆与向量检索服务。当前部署为本机 Docker 容器，由 user systemd 托管。

## 基础信息

| 属性 | 值 |
|------|-----|
| **类型** | Docker 容器（`ghcr.io/vectorize-io/hindsight:latest`） |
| **启动方式** | `~/.config/systemd/user/hindsight.service` |
| **Launcher** | `/home/shin/bin/hindsight-run.sh` |
| **监听端口** | `8888` |
| **运行机器** | 192.168.2.249（AI Center） |
| **访问地址** | `http://127.0.0.1:8888` |
| **API 版本** | `0.5.5`（`GET /version` 实测） |
| **健康状态** | `GET /health` → `{"status":"healthy","database":"connected"}` |
| **数据库** | PostgreSQL `127.0.0.1:5432/hindsight_db` |
| **启动日期** | 2026-06-21（systemd 接管） |

---

## 功能与用途

Hindsight 负责 AI Center 的长期记忆：

- `retain`：把对话/文本抽成可检索记忆
- `recall`：按语义检索历史记忆
- `reflect`：基于记忆做总结与归纳

在本机体系里，它是 `Hermes` 记忆链路的一部分，给会话存档、偏好沉淀和知识回收提供后端。

---

## 官方文档 / GitHub

- 官方安装文档：<https://hindsight.vectorize.io/developer/installation>
- 官方 GitHub：<https://github.com/vectorize-io/hindsight>
- Cookbook：<https://github.com/vectorize-io/hindsight-cookbook>

---

## 现行版本与部署方式

### 当前部署方式

- 容器镜像：`ghcr.io/vectorize-io/hindsight:latest`
- 网络模式：`host`
- 容器名：`hindsight`
- systemd unit：`hindsight.service`
- 启动脚本：`/home/shin/bin/hindsight-run.sh`

### 当前运行参数

| 参数 | 值 |
|------|-----|
| `HINDSIGHT_API_LLM_PROVIDER` | `openai` |
| `HINDSIGHT_API_LLM_BASE_URL` | `https://api.deepseek.com` |
| `HINDSIGHT_API_LLM_MODEL` | `deepseek-chat` |
| `HINDSIGHT_API_DATABASE_URL` | `postgresql://hindsight:***@127.0.0.1:5432/hindsight_db` |
| `HINDSIGHT_API_HOST` | `0.0.0.0` |
| `HINDSIGHT_API_PORT` | `8888` |
| `HINDSIGHT_CP_DATAPLANE_API_URL` | `http://localhost:8888` |
| `HINDSIGHT_ENABLE_API` | `true` |
| `HINDSIGHT_ENABLE_CP` | `true` |
| `HINDSIGHT_API_RETAIN_MAX_COMPLETION_TOKENS` | `30000` |

说明：LLM API key 从 `~/.hermes/.env` 读取，launcher 会按 `HINDSIGHT_API_LLM_API_KEY → DEEPSEEK_API_KEY → DEEPSEEK_CN_API_KEY → ARK_API_KEY` 依次兜底。

---

## 配置

### 启动入口

```bash
systemctl --user start hindsight.service
systemctl --user status hindsight.service
```

### 直接重启容器

```bash
/home/shin/bin/hindsight-run.sh
```

### 健康检查

```bash
curl http://127.0.0.1:8888/health
curl http://127.0.0.1:8888/version
```

---

## 已知 Bug / 坑点

- 以前的旧链路曾经挂在 `ark.cn-beijing.volces.com/api/coding/v3` 的 `deepseek-v3-241226` 上，配额/限频会导致抽取失败；当前不再使用那条链路。
- Hindsight 依赖外部 LLM 与 PostgreSQL；只要其中一个参数缺失，容器可能能起来但记忆链路会坏。
- `hindsight_retain` 这类同步路径历史上容易放大 worker/queue 问题；如果 recall 异常慢，优先看容器日志与 worker 状态，不要先怀疑用户输入。

---

## 个性化记录（本地部署特有）

- 当前由 user systemd 托管，不再依赖手工 `docker run`。
- 当前健康检查通过，数据库连接正常。
- 当前服务文档与 AI Center 总览已同步：`docs/README.md`。

---

## 迭代记录

| 日期 | 变更 |
|------|------|
| 2026-06-21 | 新建服务 README，补齐本机部署、启动入口与官方文档 |
| 2026-06-21 | `hindsight.service` 接管启动，launcher 固化为 `/home/shin/bin/hindsight-run.sh` |
