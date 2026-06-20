# 家庭网络总索引

> 这里记录 AI Center 的家庭网络与 HTPC 范围：PVE、路由器、旁路由、交换机、NAS、HTPC、局域网内的常驻服务，以及所有需要被 AI Center 管理的入口。
>
> 现状：**范围已定义，清单仍在盘点中**。没有核实的设备/服务，先标为 `待盘点`，不猜、不补。

## 管理规则

1. 只记录你实际在维护的家庭设备与家庭服务。
2. 结构化记录：设备、IP、入口、用途、运行状态、数据盘、恢复方式。
3. 先核验再入档；核验不了的，保留 `待盘点`。
4. 新服务如果是“运行在设备上的业务”，进 `services/`；如果是“设备/网络本体”，进这里。
5. 任何后续变更都要同步到 `docs/WIKI-索引.md`、`docs/README.md`、`homepage/README.md`。

## 实测盘点（2026-06-18）

| IP | 设备 / 服务 | 状态 | 运行中的软件 / 服务 |
|---|---|---|---|
| 192.168.2.254 | PVE / Proxmox 宿主机 | 已核实 | Debian 13 (trixie)；Proxmox VE 9.1.9；`pvedaemon` / `pveproxy` / `pvestatd` / `pve-cluster` / `pve-firewall` / `pve-ha-*` / `spiceproxy` / `docker` / `iperf3` / `postfix` / `rpcbind` / `chronyd`；VM `100 iKuaii`、`101 iStoreOS`、`102 AI-Center`；Docker：`homepage`、`vigilant_cerf` |
| 192.168.2.253 | 主路由 VM（爱快 iKuaii） | 已核实（SSH 受限） | SSH 22 开放，但当前凭据认证失败；80/443 返回 iKuai 登录页（Nginx）；PVE VM 名称 `iKuaii`，4C / 4G |
| 192.168.2.252 | 旁路由 VM（iStoreOS / OpenWrt） | 已核实 | iStoreOS 24.10.5；`dropbear` / `uhttpd` / `dnsmasq` / `wsdd2` / `ttyd` / `linkease` / `FastNet` / `smbd` / `rpcbind` / `docker`；OpenClash 监听 `7874`、`7890-7895`、`9090`；Samba/NFS 已装；VM 名称 `iStoreOS`，2C / 2G |
| 192.168.2.251 | 无线路由器 / AP | 已核实（SSH 未开） | 80/443 开放，页面为 LuCI 登录跳转页；常见端口未见 SSH；当前只确认到 Web 管理口和 DNS / Web 管理存在 |
| 192.168.2.250 | mesh 路由器 | 待盘点 / 暂未启用 | 常见端口未发现开放，暂按未上线或闲置处理 |
| 192.168.2.249 | Ubuntu AI 主机 | 已核实 | Ubuntu 24.04.4 LTS；`hermes-gateway` / `hermes-webui` / `openclaw-gateway` / `cloudflared` / `tailscaled` / `docker` / `postgresql@16-main` / GNOME 桌面会话 / `pipewire` / `cups` / `avahi`；Docker：`litellm`、`litellm-db`、`alist`、`hindsight`、`searxng`；监听 `8642`、`18789`、`4000`、`5244`、`7777`、`5432` |

## 当前结论

- 254 是 PVE 宿主，实际承载 100 / 101 / 102 三台虚拟机。
- 253 是主路由爱快 VM，Web 管理可达，SSH 目前被当前凭据挡住。
- 252 是 iStoreOS 旁路由，OpenClash 和多种文件 / 共享 / 容器服务都在跑。
- 251 是无线 AP / 路由器，至少有 LuCI Web 管理口。
- 250 当前没有发现可用管理入口，先保留为待盘点。
- 249 是 AI 主机，运行 Hermes / OpenClaw / LiteLLM / OpenList / Hindsight / SearXNG 等核心服务。

## USAGE_MANUAL

### 盘点 / 健康检查

| 字段 | 值 | 说明 |
|---|---|---|
| 检查对象 | 254 PVE、253 主路由、252 旁路由、251 AP、250 mesh、249 AI 主机 | 先看对象全不全 |
| 检查命令 | `ping` / `ssh` / `curl` / `ss` / `docker ps` / `pvesh` | 按对象选择命令 |
| 判据 | 设备在线、管理口可达、核心服务可访问、文档同步 | 至少满足一项可确认 |
| 频率 | 新盘点后 / 设备变更后 / 周期巡检 | 变更即查 |
| 失败动作 | 先标 `待盘点` 或 `待救`，再补证据，不直接删档 | 先保守处理 |

### 备份

| 字段 | 值 | 说明 |
|---|---|---|
| 备份对象 | 设备清单、拓扑关系、管理入口、关键配置来源 | 以可恢复为准 |
| 备份方式 | Git 归档 + 相关配置源文件 + 凭证总册引用 | 不要只剩口头记忆 |
| 频率 | 每次新增设备 / 新增服务 / 变更后 |  |
| 保留策略 | 保留现态 + 历史态 + 迁移态 | 三层保留 |
| 恢复命令 | 还原文档 + 重新核验 live 设备与服务 | 先核验再恢复 |

### 告警

| 字段 | 值 | 说明 |
|---|---|---|
| 告警条件 | 设备失联、管理口变更、服务掉线、拓扑漂移 | 任一即异常 |
| 通知渠道 | 微信 / 运维文档 |  |
| 兜底动作 | 标记待救/待盘点，先查 live 状态 | 不猜 |
| 升级路径 | 先补证据，再决定修复或清档 |  |

### 恢复 / 回滚

- 恢复前置条件：知道对象的真实角色、管理口和替代关系
- 回滚步骤：恢复文档引用 → 恢复入口/配置 → 复核 live 状态
- 恢复后验证：主页入口、SSH/HTTP、关键服务端口
- 恢复失败的下一步：继续保留现态描述，追加待核实项

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-18 | 完成家庭网络范围定义与首次实测盘点 |
| 2026-06-20 | 纠正 249 当前态服务名：`AList` → `OpenList`，同步现态口径 |

## 下一步

- 把 250 号 mesh 路由器的品牌、是否上电、管理口、用途补齐。
- 如果你要，我下一步直接把这些盘点同步进 `docs/AI-Center-拓扑图.md` 和 `docs/README.md`。
- 每个新服务都按 `README → 凭证 → WIKI → 拓扑 → 总览 → 健康/备份` 接入。
