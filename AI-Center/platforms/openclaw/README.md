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

OpenClaw 的**网关端口是 `18789`**；这不是 Hermes 的端口。档案库里以后要把 `18789` 明确标成 OpenClaw Gateway。

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

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | `18789` 网关端口 / OpenClaw 进程 | 执行层本体 |
| 检查命令 | `ss -tlnp | grep 18789`；`systemctl --user status hermes-gateway` | 端口 + 进程 |
| 判据 | 18789 监听且 gateway 正常 | 可路由 |
| 频率 | 启动后 / 改插件后 / 故障排查时 | 变更即查 |
| 失败动作 | 先查网关日志，再查插件与配置 | 先网关后插件 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/.openclaw/openclaw.json`、`extensions/`、相关插件配置 | 核心可恢复项 |
| 备份方式 | Git / 目录快照 | 配置优先 |
| 频率 | 改渠道 / 改插件前 | 变更前备份 |
| 保留策略 | 保留最近可回滚版本 | 可回滚即可 |
| 恢复命令 | 恢复配置后重启 gateway | 配置回放 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | 18789 不通、渠道插件失败、路由错误 | 任一即异常 |
| 通知渠道 | 当前无自动告警 | 先人工发现 |
| 兜底动作 | 先停变更，再查插件和网关日志 | 先止血 |
| 升级路径 | 先恢复网关，再修插件 | 分层排障 |

### 恢复 / 回滚

- 回滚 `openclaw.json`
- 重新加载插件和 gateway

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 初始部署，与 Hermes 集成 |
| 2026-04 | 微信插件接入 |
