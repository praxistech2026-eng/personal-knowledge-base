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

与 OpenClaw 共用 `openclaw-gateway` 进程，但独立配置和会话管理。

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

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 初始部署 |
| 2026-05 | 接入 Hindsight 记忆系统、飞书/微信集成 |
