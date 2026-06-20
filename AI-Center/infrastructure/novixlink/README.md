# NovixLink VPS

> NovixLink 新购境外 VPS，原 Praxis VPS 失效后的替代节点。
>
> 注册邮箱 / 密码属于服务商账号，存放在 `credentials/系统凭证备忘录.md` 中。

## 接入信息

| 属性 | 值 |
|------|-----|
| 服务商 | NovixLink |
| IP | 149.7.2.186 | 替代原 Oracle Cloud（`146.235.234.135`，已失效并清档，2026-06-20） |
| SSH 端口 | 5522 |
| SSH 用户 | root |
| SSH 密码 | 67748299 |
| 注册邮箱 | 253620@qq.com |
| 服务商密码 | andre0 |

## 用途

- **正式替代原 Oracle Cloud VPS（`146.235.234.135`，2026-06-20 sshd 应用层挂掉失效）**
- 承接原 Oracle 上的服务：VLESS+SS AI 主落地、Vless+SS 翻墙代理、网络加速节点
- 替代原 Praxis VPS
- 当前为唯一境外 VPS 节点

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | NovixLink VPS SSH 可达性 | 这不是本地服务，是可达性对象 |
| 检查命令 | `ssh -p 5522 root@149.7.2.186` | 自定义端口 |
| 判据 | SSH 可登录 | 保持可恢复 |
| 频率 | 改网络 / 改防火墙 / 故障时 | 变更即查 |
| 失败动作 | 先查服务商控制台 → 控制台 VNC → 救砖 | 先恢复访问 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/.ssh/`、主机配置、已部署服务 | 关键是入口和密钥 |
| 备份方式 | 本地密钥备份 + 文档化部署步骤 | 密钥不进 md 明文 |
| 频率 | 改密钥 / 改防火墙 / 部署前 | 变更前备份 |
| 保留策略 | 保留最近可用密钥和恢复步骤 | 可恢复优先 |
| 恢复命令 | 按服务商文档走 VNC / 控制台 | 恢复访问优先 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | SSH 不通、控制台失效、服务到期 | 任一即异常 |
| 通知渠道 | 当前无自动告警 | 先人工发现 |
| 兜底动作 | 先走服务商控制台，不直接重装 | 优先保数据 |
| 升级路径 | 先恢复 SSH，再查服务层 | 分层排障 |

### 恢复 / 回滚

- 优先恢复 SSH（密码登录 + 控制台 VNC）
- 再按文档恢复业务服务
- NovixLink 控制台地址待补

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-20 | 新购 NovixLink VPS，替代失效的 Praxis VPS；写入档案库 |
| 2026-06-20 | 实测验证：SSH 通；Ubuntu 24.04.4 LTS；内核 7.0.13-xanmod1；主机名 `VM-Shin`；Docker 桥接网已建（`docker0`/`br-e8e4dcf9ea28`） |
| 2026-06-20 | xray 部署完成：VLESS(443)+SS(8388) 同一实例同进程；TLS 证书 Let's Encrypt ECC-256（acme.sh 自动续期）；hhy.wang 域名（DNSPod）DNS A 已指向 149.7.2.186；OpenClash 配置文件生成（`config/clash-fallback-dialer_场景优化版_NovixLink.yaml` + workspace/v17） |
| 2026-06-20 | **AI 主落地链式代理**：NovixLink VLESS/SS 节点加 `dialer-proxy: 🇺🇸 美国-故转`，新建 `🇺🇸 AI-主落地` fallback 组（VLESS 主 / SS 备，同 IP 同身份），接入 `🧠 AI-普通` 策略组置顶；`🤖 AI-高敏固定` 按用户要求保持原状（含住宅链式 + 机场节点，不引入 AI 主落地）。xray 服务端不变（仍监听 443+8388，链式在 OpenClash 客户端侧实现）。 |

## 已部署服务

| 服务 | 端口 | 状态 | 说明 |
|------|------|------|------|
| ghproxy | 8046 | ✅ 运行 | Docker 容器 `wjqserver/ghproxy` |
| nezha-dashboard | 8008 | ✅ 运行 | Docker 容器 `ghcr.io/nezhahq/nezha`，监控面板 |
| myip | — | ❌ 退出 | Docker 容器已退出，待清理 |
| **VLESS (AI 主落地)** | **443** | **✅ 运行** | xray (teddysun/xray:latest)，WS+TLS |
| **SS (AI 主落地)** | **8388** | **✅ 运行** | xray 同实例同进程，chacha20-ietf-poly1305 |

### xray 配置详情

| 项 | 值 |
|----|-----|
| 域名 | `hhy.wang`（DNSPod 管理，DNS A → 149.7.2.186） |
| TLS 证书 | Let's Encrypt ECC-256，acme.sh 自动续期（cron 每日 7:28） |
| 配置文件 | `/opt/xray/config.json` |
| docker-compose | `/opt/xray/docker-compose.yml`（network_mode: host） |
| 证书路径 | `/opt/xray/certs/{fullchain,privkey}.pem` |
| 凭据（本地） | `~/.novixlink-secrets/credentials.json`（chmod 600） |
| 部署脚本 | `~/.novixlink-secrets/deploy.sh` |

> 2026-06-20 完成重建。承接原 Amazon（`170.9.16.186` = `hhy.wang` 旧指向）和 Oracle Cloud（`146.235.234.135`）的 AI 主落地角色。客户端 OpenClash 配置详见 `config/花云_Mitce_Webshare_NovixLink场景优化版.yaml`。

### Webshare 住宅链式节点（明码）

> 2026-06-20 用户提供。Webshare 网站用 Google 登录，作为 AI 高敏链式落地的住宅出口。

| 项目 | 值 |
|------|-----|
| 节点名 | `🏠 美国住宅` |
| 类型 | socks5 |
| server | `208.66.74.168` |
| port | `5483` |
| username | `jquairff` |
| password | `tq3707vm3u6o` |
| udp | true |
| dialer-proxy | `🇺🇸 美国-故转`（前置走机场美国节点） |

> 2026-06-20 实测：TCP 5483 可达。Webshare 年流量有限（250GB/年），只用于低流量高风控场景（AI 高敏、支付、账号身份）。

## 待补清单

- NovixLink 服务商控制台登录地址
- 原 Praxis VPS 上的服务清单（迁移前先盘点）
- 原 Oracle Cloud 上的服务清单（VLESS+SS AI 主落地已迁移到 NovixLink ✅）
- 原 Amazon AI 主落地（`170.9.16.186`）上的其他服务（按需盘点）
- SS 密码轮换计划（已轮换 1 次防 stdout 泄露，下次轮换时间待定）