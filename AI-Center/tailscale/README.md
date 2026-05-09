# Tailscale

> 加密 VPN，用于远程访问家庭服务器。

## 官方资源

| 资源 | 链接 |
|------|------|
| 官网 | https://tailscale.com/ |

## 本节点信息

| 属性 | 值 |
|------|-----|
| Tailnet | shin |
| 本机节点名 | shin |
| 本机 IP | 100.113.209.2 |
| 域名 | shin.tail8a16d3.ts.net |
| Mac 节点 | wangxindemacbook-pro @ 100.114.100.50 |

## 在本生态中的角色

**远程访问基础设施**。通过 Tailscale VPN，从外网安全连接到家庭服务器，访问 Hermes Gateway、hermes-webui、SearXNG 等所有服务。

## 常用命令

```bash
# 查看状态
tailscale status

# Ping 节点
tailscale ping shin

# SSH 连接到服务器
ssh shin@100.113.209.2
```

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署完成，Mac 远程连接 |
