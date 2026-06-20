# Homepage 门户

> 这里放 AI Center 的门户配置副本。实时状态写 `services.yaml` / `bookmarks.yaml`，长期事实写档案库。
> 这里的门户范围覆盖 AI 主机、HTPC、家庭网络设备和外部入口；如果卡片上没看到明显状态，不代表没记录，而是视觉层可能还没把结构化状态单独画出来。

## 文件

- [services.yaml](./services.yaml)：本机服务、待恢复服务、状态面板
- [bookmarks.yaml](./bookmarks.yaml)：文档、外部平台、远程入口

## 规则

1. `services.yaml` 只放本机或本地网络里的可运维目标。
2. `bookmarks.yaml` 只放文档、厂商门户、远程入口、非本机服务。
3. 状态字段必须结构化，不能写进 description 里糊弄；视觉层若不显式展示状态，以 `services.yaml` / `bookmarks.yaml` + watchdog 为准。
4. `running` 只表示实机可达。
5. `installed-not-running` 要明确进入待恢复视角。
6. 401 / 403 代表服务在，但要登录。
7. `external` 永远不探测。
8. Homepage 不只是导航页，还是仪表盘：要尽量让人一眼看懂“现在什么在跑、什么异常、下一步该处理什么”。
9. 仪表盘优先显示 **服务状态 + 风险等级**；如果能再给出下一步动作更好，但不是强制。
10. 若页面暂时无法承载足够状态，就把状态留在 watchdog / cron / 运维文档里，别假装卡片已经足够。

## 探针语义

- `localhost`：`127.0.0.1` / `localhost`
- `lan`：`192.168.x.x` / `10.x.x.x` / `172.16-31.x.x`
- `tailnet`：Tailscale 入口
- `external`：外部站点，不探测

## 当前状态

- **同步状态（2026-06-18）**：254 上的 Homepage live panel 已同步 OpenList（核心服务 + Tailscale 书签）；执行清单见 `254同步操作清单.md` § 操作记录
- `n8n` 当前是 **installed-not-running**。
- 其他核心服务在本次核验时都保持在线。
- `Homepage 链接校验` 已在 cron 里接入，后续新增服务要先补配置，再让 watchdog 接管校验。

## 维护顺序

1. 先改 `services.yaml` / `bookmarks.yaml`
2. 再同步 `operations/巡检项总表.md`
3. 再同步 `docs/README.md` 和 `docs/WIKI-索引.md`
4. 最后再让巡检脚本跑一轮
