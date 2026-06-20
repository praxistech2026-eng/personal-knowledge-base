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

**远程访问基础设施**。通过 Tailscale VPN，从外网安全连接到家庭服务器，访问 OpenClaw Gateway、Hermes API Server、hermes-webui、SearXNG 等所有服务。

## 常用命令

```bash
# 查看状态
tailscale status

# Ping 节点
tailscale ping shin

# SSH 连接到服务器
ssh shin@100.113.209.2
```

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | Tailscale 客户端与 Tailnet 连接 | 无本地业务进程 |
| 检查命令 | `tailscale status`；`tailscale ping shin` | 状态与连通性 |
| 判据 | 节点在线且可 ping 到目标节点 | 可达即健康 |
| 频率 | 启机后 / 网络变更后 / 远程访问异常时 | 变更即查 |
| 失败动作 | 先重连 Tailscale，再查路由与 DNS | 先恢复网路 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | Auth key、设备名、Tailnet 配置、远程访问路径 | 关键是身份和路由 |
| 备份方式 | 文档记录 + 安全存放凭证 | 凭证不写明文 |
| 频率 | 改设备 / 改路由前 | 变更前备份 |
| 保留策略 | 保留最近可恢复身份信息 | 可重建即可 |
| 恢复命令 | 重新登录 Tailnet 并确认 `tailscale status` | 重新入网 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | 节点掉线、无法 ping、IP 变化导致访问失败 | 任一即异常 |
| 通知渠道 | 当前无自动告警 | 先人工发现 |
| 兜底动作 | 切换到本地或救援访问路径 | 先保证可达 |
| 升级路径 | 先恢复 Tailnet，再查目标主机 | 先网后服务 |

### 恢复 / 回滚

- 重新登录 Tailnet
- 必要时重置设备节点并重新授权

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署完成，Mac 远程连接 |
