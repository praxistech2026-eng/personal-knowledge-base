# Hermes Agent

> NousResearch 开源的自进化 AI Agent 框架，支持多后端、多消息平台、内置工具和自我优化记忆。

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub | https://github.com/nousresearch/hermes-agent |
| 官方文档 | https://hermes-agent.nousresearch.com/docs |
| CLI 参考 | https://hermes-agent.nousresearch.com/docs/reference/cli-commands |

## 功能

- **自我进化学习循环**：跨会话记忆召回、技能自创建、用户建模
- **多执行后端**：local / docker / ssh / modal / daytona / vercel_sandbox / singularity
- **消息网关**：支持 Telegram、Discord、Slack、WhatsApp、Signal、Teams、Email、飞书、微信等
- **内置工具**：网页搜索/抓取、浏览器控制、视觉、图像生成、语音合成
- **MCP 集成**：支持外部工具服务器
- **定时任务**：自然语言配置的 cron 作业
- **并行化**：隔离子 Agent 并发工作流
- **Web Dashboard**：本地浏览器 UI（配置、会话、日志、分析、API Keys）

## 在本生态中的角色

**决策层 + 对外接口**。Hermes 是整个系统的核心 Agent，负责：
- 接收用户指令（通过飞书/微信/webui）
- 调度工具和子任务
- 管理长期记忆（Hindsight）
- 驱动自我进化流程

Hermes 的**官方 API Server 默认端口是 `8642`**；当前本机监听 `127.0.0.1:8642`，`/health` 返回 ok。`hermes-webui` 是 `8787`。`18789` 不是 Hermes 的端口名，别再把它混成 Hermes。

与 OpenClaw 在本地运行时会共享底层 gateway 生态，但角色和对外入口必须分开写。

## 配置

```
~/.hermes/
├── config.yaml       # 非敏感配置
├── .env              # API Keys 和密钥
├── SOUL.md           # Agent 身份/人格定义
├── memories/         # 内置记忆
├── skills/           # 技能系统
├── sessions/         # 会话记录
└── logs/            # 日志
```

### 关键配置项

```bash
# Model / Provider
hermes config set model MiniMax-M2.7
hermes config set providers.minimax.request_timeout_seconds 120

# Terminal 后端
hermes config set terminal.backend local
hermes config set terminal.timeout 300
```

## 常用命令

```bash
# 配置
hermes config edit
hermes config set model <model>
hermes config check

# 会话
hermes sessions list
hermes chat -q "问题"

# Cron
hermes cron list

# 技能
hermes skills list
hermes curator list

# 状态
hermes status
hermes doctor
```

## hermes-webui

独立运行的 Python Web 服务，提供浏览器端管理界面。

| 属性 | 值 |
|------|-----|
| 进程 | `~/.hermes/hermes-agent/.venv/bin/python .../server.py` |
| 端口 | 8787 |
| LAN 访问 | ✅ `http://<IP>:8787` |

> ⚠️ 无认证，建议内网使用。

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | Hermes API Server `127.0.0.1:8642` + hermes-webui `8787` | 主接口 + WebUI |
| 检查命令 | `curl -s http://127.0.0.1:8642/health`；`ss -tlnp | grep -E '8642|8787'` | 端点与端口 |
| 判据 | `/health` 返回 `{"status":"ok"}`，且 8642/8787 按当前角色监听 | 本机可用 |
| 频率 | 启动后 / 改配置后 / 故障排查时 | 变更即查 |
| 失败动作 | 先看日志与进程，分别恢复 API Server 或 WebUI | 先定位再重启 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/.hermes/config.yaml`、`~/.hermes/.env`、`~/.hermes/skills/`、`~/.hermes/memories/` | 关键配置与能力 |
| 备份方式 | Git / 密钥备份 / sessions-backup / Hindsight 记忆层 | 分层保存 |
| 频率 | 每次变更前 + 例行同步 | 配置变更优先 |
| 保留策略 | 原始会话由 sessions-backup 维护，配置与技能走 Git 版本化 | 不删源数据 |
| 恢复命令 | 从 Git / 备份恢复后重启 Hermes 与 webui | 按目录回放 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | `8642` 或 `8787` 不通、`/health` 非 ok、启动报错 | 任一即异常 |
| 通知渠道 | 暂未接入独立自动告警；现由巡检记录补位，微信/飞书接口预留 | 现状如实写 |
| 兜底动作 | 停止变更，先查日志再重启对应进程 | 避免盲修 |
| 升级路径 | 先本机排障，再人工介入 | 不做假自动化 |

### 恢复 / 回滚

- 配置错误：回滚 `config.yaml` / `.env`
- WebUI 异常：重启 `server.py`
- 入口异常：确认 8642/8787 角色未被混淆

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 初始部署 |
| 2026-05 | 接入 Hindsight 记忆系统、飞书/微信集成 |
