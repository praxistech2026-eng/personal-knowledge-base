# 微信集成

> 通过 OpenClaw WeChat 插件接入个人微信账号。

## 官方资源

| 资源 | 链接 |
|------|------|
| OpenClaw WeChat 插件 | `~/.openclaw/extensions/openclaw-weixin` |
| OpenClaw 文档 | https://docs.openclaw.ai/ |

## 在本生态中的角色

**消息入口之一**。用户可通过微信与 Hermes 对话。

> ⚠️ 微信接入存在风险，请注意合规使用。

## 接入配置

| 属性 | 值 |
|------|-----|
| 插件 | `@tencent-weixin/openclaw-weixin` |
| 版本 | 2.1.8 |
| Account ID | `1152b1001190-im-bot` |
| Token | 见 `~/.hermes/.env` 的 `WEIXIN_TOKEN` |

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 安装插件 v2.1.8 |
