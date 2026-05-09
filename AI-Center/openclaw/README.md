# OpenClaw

> 开源 AI 网关框架，连接聊天/消息平台到 AI Agent，支持多渠道和多 Agent 路由。

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub | https://github.com/openclaw/openclaw |
| 官方文档 | https://docs.openclaw.ai/ |

## 功能

- **多渠道支持**：Discord、Slack、Telegram、WhatsApp、Teams、Matrix、Signal 等
- **多 Agent 路由**：隔离会话和 Agent 路由
- **内置工具**：浏览器、文件系统、exec/runtime、会话管理、网页、媒体
- **插件系统**：渠道插件、模型提供商插件、语音插件、记忆插件
- **工作区隔离**：每个 Agent 有独立工作区

## 在本生态中的角色

**执行层**。OpenClaw 与 Hermes 共用 `openclaw-gateway` 进程，是 Hermes 的底层执行引擎。微信接入层也依赖 OpenClaw 插件。

## 配置

```
~/.openclaw/
├── openclaw.json     # 主配置
└── extensions/       # 插件目录
```

## 关键配置项（openclaw.json）

```json
{
  "channels": {},
  "agents": {
    "defaults": {
      "model": { "primary": "MiniMax-M2.7" },
      "workspace": "~/.openclaw/workspace"
    }
  },
  "plugins": {
    "enabled": ["openclaw-weixin"]
  }
}
```

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 初始部署，与 Hermes 集成 |
| 2026-04 | 微信插件接入 |
