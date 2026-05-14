# Hindsight

> 面向 AI Agent 的长期记忆系统，支持向量检索、实体关系图谱和时间推理。

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub | https://github.com/vectorize-io/hindsight |
| 官方文档 | https://hindsight.vectorize.io/ |
| PyPI | https://pypi.org/project/hindsight-api/ |

## 功能

- **核心操作**：retain() 存储 / recall() 检索 / reflect() 推理
- **多类型记忆**：World Facts、Experiences、Mental Models、Observations
- **TEMPR 检索**：语义检索 + BM25 关键词 + 图谱关系 + 时间推理
- **自动整合**：相关事实自动合成为 Observations
- **推理控制**：Mission（使命）/ Directives（指令）/ Disposition（性格）
- **隔离记忆库**：不同 Agent/场景使用独立 Bank，互不干扰

## 在本生态中的角色

**记忆层**。Hermes 的所有会话经验通过 `session_archive.py` 归档到 Hindsight，Agent 可随时通过 recall 查询历史记录。

部署形态：PostgreSQL（本地）+ API 服务（Docker/独立进程）。

## 部署信息

| 属性 | 值 |
|------|-----|
| API 服务 | `http://127.0.0.1:8888` |
| PostgreSQL | `127.0.0.1:5432` |
| 数据库 | `hindsight_db` |
| Bank ID | `Hermes` |
| 进程 | `hindsight-api`（systemd 托管） |

## 当前运行策略（2026-05-15）

- `auto_recall=false`：召回只在需要时触发，不做 turn 级自动召回。
- `auto_retain=false`：默认关闭 turn 级自动 retain，避免会话推进时持续烧 token。
- `retain_async=true`：显式 retain 仍走异步。
- `retain_every_n_turns=10`：作为安全兜底阈值，不再是 1 turn 一抽。
- 高价值写入优先走显式 `retain()` / 备份管线；自动化会话由 `session-backup.py` 的直接入库链路承接，不走 LLM 抽取。
- token stop-loss 由 `~/.hermes/scripts/hindsight_token_watchdog.py` 负责，命中时优先查 `retain_extract_facts` 重试、stale `batch_retain`、以及模型路由。

## 核心 API 端点

```
GET  /health                          # 健康检查
GET  /v1/default/banks/{bank_id}/stats          # 统计
POST /v1/default/banks/{bank_id}/memories       # 存储记忆
GET  /v1/default/banks/{bank_id}/memories/list   # 列出记忆
POST /v1/default/banks/{bank_id}/memories/recall # 向量检索
POST /v1/default/banks/{bank_id}/reflect         # 推理
```

## 常用命令

```bash
# 配置 CLI
hindsight configure --api-url http://localhost:8888

# 记忆操作
hindsight memory retain <bank_id> "信息内容"
hindsight memory recall <bank_id> "查询内容"
hindsight memory reflect <bank_id> "关于XXX你知道什么"

# Bank 管理
hindsight bank list
hindsight bank stats <bank_id>
```

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署完成，接入 session_archive.py |
