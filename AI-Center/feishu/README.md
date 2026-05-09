# 飞书集成

> 通过 OpenClaw Feishu 插件接入飞书消息平台。

## 官方资源

| 资源 | 链接 |
|------|------|
| 飞书开放平台 | https://open.feishu.cn/ |
| OpenClaw 文档 | https://docs.openclaw.ai/ |

## 在本生态中的角色

**消息入口之一**。用户可通过飞书机器人与 Hermes 对话。

## 接入配置

| 属性 | 值 |
|------|-----|
| 插件 | `channels.feishu` |
| App ID | `cli_a951cc68c0789cee` |
| App Secret | `gUC1mThDY8JklxkPV3czGcbSq4GLslAb` |
| 订阅事件 | `im.message.receive_v1` |
| 用户 ID 类型 | `open_id`（格式：`ou_xxx`） |

> 凭证保存在 `~/.openclaw/feishu/` 配置中

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 接入完成 |
