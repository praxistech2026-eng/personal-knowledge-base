# OpenList 调研报告

> 调研日期：2026-06-17
> 决策类型：**从 AList 迁移到 OpenList**（替换不是并跑）
> 调研目的：确认 OpenList 在 2026 年仍是"网盘聚合"赛道最强开源选项；查明最新版本、镜像、部署变更；为 AI Center 运维标准化沉淀依据

---

## 1. 决策结论

| 问题 | 答案 |
|---|---|
| **OpenList 在 2026 年仍是网盘聚合赛道最强开源项目吗？** | ✅ 是 |
| **比 AList 强在哪？** | 治理透明 + 无 telemetry + 社区驱动 + AGPL-3.0 锁定 |
| **比 AList 弱在哪？** | 生态成熟度（fork 仅 1 年），部分 edge case 还在暴露中 |
| **驱动兼容性（特别是夸克）有差异吗？** | ❌ 无差异——驱动代码主体共用，夸克一样烂 |
| **能直接迁移 AList 的 data.db 吗？** | ✅ 同 fork 直接兼容（API/数据格式一致） |
| **现在迁移吗？** | ✅ 现在迁移（迁移成本几乎为零：AList 只跑了 2 周、无挂载、无用户） |

---

## 2. OpenList 项目现状（2026-06-17）

### 2.1 基础信息

| 项 | 值 |
|---|---|
| **GitHub** | https://github.com/OpenListTeam/OpenList |
| **官方文档** | https://doc.oplist.org |
| **License** | AGPL-3.0 |
| **Slogan** | "A new AList Fork to Anti Trust Crisis" |
| **fork 时间** | 2025-06（原 AList 项目易主 + 隐藏 telemetry 事件后） |
| **主分支 commits** | 2,754 |
| **Releases 数** | 25 |
| **最新稳定版** | **v4.2.2**（commit b28208b，发布者 @Suyunmeng） |
| **活跃度** | ⭐⭐⭐⭐ 高，最近 6 个月发布 10+ 个版本 |

### 2.2 关键 release cadence（近 6 个月）

| 版本 | 发布者 | 类别 |
|------|--------|------|
| v4.2.2 | @Suyunmeng | Breaking + Features + BugFix + Perf |
| v4.2.1 | @Suyunmeng | BugFix |
| v4.2.0 | @PIKACHUIM | Breaking + Features + BugFix |
| v4.1.10 | @PIKACHUIM | Features + BugFix + Perf |
| v4.1.9 | @PIKACHUIM | Features + BugFix |
| v4.1.8 / 4.1.7 / 4.1.6 | @PIKACHUIM | Features + BugFix |

**注**：v4.2.0 含 Breaking Changes（数据格式或 API 路径可能变），**跨大版本升级要先看 release notes**。

### 2.3 治理与社区

| 维度 | 状态 |
|---|---|
| **主要维护者** | @PIKACHUIM（v4.1.x 主线）+ @Suyunmeng（v4.2.x） |
| **活跃 contributor** | @jyxjjj @xrgzs @KirCute @sevxn007 @mkitsdts（多人协作，非单点） |
| **赞助商** | VPS.Town（透明赞助） |
| **官方反对仿冒** | README 明确点名 **OpenListApp/OpenListApp** 等仿冒项目，**没有官方关联** |
| **付费产品？** | ❌ 无任何付费版本/商业部署，**纯社区** |
| **telemetry** | ❌ **无**（这是与 AList 最大区别） |

---

## 3. OpenList vs AList 关键差异（决策依据）

| 维度 | AList v3.61 | OpenList v4.2.2 |
|---|---|---|
| **治理** | 单家公司/个人维护 | 社区驱动，多人协作 |
| **telemetry** | ⚠️ 默认开启，用户未察觉 | ❌ 无 |
| **License** | AGPL-3.0 | AGPL-3.0（明确锁定，禁止闭源分发） |
| **驱动列表** | 30+ | 30+（**基本一致**，fork 自同一主线） |
| **API 兼容性** | 标准 | 与 AList 完全兼容（连 admin 命令 `alist admin` 都保留为别名） |
| **数据迁移** | — | ✅ 直接挂载 AList 的 `data/` 目录即可（SQLite 兼容） |
| **Web UI** | 同 AList | 同 AList + 新图标 |
| **资源占用** | 极低 | 极低 |
| **Docker 镜像** | `xhofe/alist:latest`（amd64） | `openlistteam/openlist:latest`（**amd64 + arm64 都齐**） |
| **文档站** | alist.nn.ci（多次被攻击） | doc.oplist.org（独立维护） |

---

## 4. 关键变更：v4.1.0+ Docker 部署变更（重要）

### 4.1 PUID/PGID 已废弃

> 在 v4.1.0 以后的版本中（不包含 v4.1.0），OpenList 镜像已经移除了 `PUID`、`PGID`，并借鉴 MariaDB 的构建方式，使用 `useradd` 增加了用户 `openlist`（UID 1001）和组 `openlist`（GID 1001），并使用该用户运行 `openlist server`。

**部署选项**（v4.2+）：

| 选项 | 命令模板 | 适用场景 |
|---|---|---|
| **A. 用容器内 openlist(1001)** | `docker run ... -v /home/shin/workspace/services/openlist/data:/opt/openlist/data`（需要宿主机目录 chown 到 1001） | 追求隔离 |
| **B. 显式指定 --user 0:0** | `docker run --user 0:0 ...`（容器内以 root 跑） | ✅ **本项目采用**（与原 AList 一致，最少坑） |
| **C. rootless Docker** | `--user $(id -u):$(id -g)` | 无 root sudo 权限的环境 |

### 4.2 新增环境变量

| 变量 | 用途 |
|---|---|
| `OPENLIST_ADMIN_PASSWORD` | 启动时直接设 admin 密码（免去重置流程） |
| `TZ` | 时区（如 `Asia/Shanghai`） |
| `UMASK` | 文件权限掩码 |

### 4.3 镜像 tag 矩阵

| Tag | 大小 | 用途 |
|---|---|---|
| `latest` | ~50MB | 标准版 |
| `latest-lite` | ~35MB | 轻量（<100MB PaaS 友好） |
| `latest-aria2` | ~60MB | 内置离线下载 |
| `latest-ffmpeg` | ~88MB | 内置缩略图生成 |
| `latest-aio` | ~107MB | aria2 + ffmpeg 全套 |
| `v4.2.2` | 同 latest | 锁定版本（生产推荐） |

---

## 5. 镜像与架构（关键实测）

| 架构 | OpenList 镜像 | AList 镜像 |
|---|---|---|
| **linux/amd64** | ✅ 有 | ✅ 有（`xhofe/alist`） |
| **linux/arm64** | ✅ 有 | ❌ **只有 `alist666/alist`，官方 `xhofe/alist` 没有 arm64** |

**结论**：OpenList 镜像的**架构覆盖比 AList 更全**，NAS / 软路由 / Apple Silicon 用户终于不用担心架构问题。

---

## 6. 部署方案（采用）

### 6.1 决策

| 项 | 选择 | 理由 |
|---|---|---|
| 镜像 | `openlistteam/openlist:latest` | 稳定 + amd64 |
| 容器名 | `openlist` | 跟随官方命名 |
| 数据目录 | `/home/shin/workspace/services/openlist/data` | 与 AI Center 现有 services 风格一致 |
| 端口 | `5244` | 沿用 AList 端口（用户已习惯） |
| 用户模式 | `--user 0:0` | 避免 chown 麻烦、与原 AList 一致 |
| TZ | `Asia/Shanghai` | 与 AI Center 一致 |

### 6.2 docker run 命令

```bash
docker run -d \
  --name openlist \
  --restart unless-stopped \
  --user 0:0 \
  -v /home/shin/workspace/services/openlist/data:/opt/openlist/data \
  -p 5244:5244 \
  -e UMASK=022 \
  -e TZ=Asia/Shanghai \
  openlistteam/openlist:latest
```

### 6.3 部署后加固（强制）

1. 重置 admin 密码 → 写 `~/.hermes/.env`（chmod 600）
2. 关闭 3 项访客权限：`allow_register / allow_mounted / allow_indexed = false`
3. 验证 Web + LAN 双栈访问

---

## 7. 风险与限制

### 7.1 OpenList 独有风险

| 风险 | 影响 |
|---|---|
| **Fork 仅 1 年** | 部分 edge case 还在暴露，生产前先跑两周观察 |
| **文档站依赖 Cloudflare 慈善资源** | 理论上可能因 Cloudflare 政策变化而中断（概率极低） |
| **生态不如 AList 成熟** | HomePage / NAS 厂商内置 / 第三方教程多围绕 AList |

### 7.2 网盘驱动通用风险（OpenList 也救不了）

| 网盘 | 现状 |
|---|---|
| **夸克** | 逆向接口，限速严，Cookie 频繁失效——任何工具都救不了 |
| **阿里云盘 Open** | 大文件限速、官方强调"禁止公开分享/多 IP 访问" |
| **百度网盘** | refresh_token 偶尔失效 |
| **OneDrive E5/Google** | 相对稳 |

### 7.3 数据安全

| 项 | 措施 |
|---|---|
| 备份 | `/home/shin/workspace/services/openlist/data` 加入 services-backup 流水线 |
| 升级 | 大版本前先看 release notes（v4.2.0 已出现 Breaking Changes） |
| telemetry | OpenList 默认无，仍建议用 `--user 0:0` 减少容器外接触面 |

---

## 8. 迁移清单

### 8.1 已完成

- [x] AList 容器停止并删除
- [x] AList 镜像删除（`xhofe/alist:latest`）
- [x] AList 数据目录清理（`/home/shin/workspace/services/alist/`）
- [x] `.env` 中 `ALIST_*` 变量清理
- [x] AI Center `services/alist/` 档案清理
- [x] 5244 端口确认空闲

### 8.2 待执行

- [ ] OpenList 容器启动
- [ ] 初始密码抓取 + 重置 + 写 .env
- [ ] 关闭 3 项访客权限
- [ ] LAN 访问验证
- [ ] AI Center 入驻（README + WIKI + 拓扑图 + 凭证备忘录 + 更新日志）

---

## 9. 参考资料

- GitHub: https://github.com/OpenListTeam/OpenList
- Releases: https://github.com/OpenListTeam/OpenList/releases
- Docker Hub: https://hub.docker.com/r/openlistteam/openlist
- 官方文档: https://doc.oplist.org
- Docker 安装指南: https://doc.oplist.org/guide/installation/docker
- 原 AList 信任危机事件: https://finance.sina.com.cn/tech/roll/2025-06-17/doc-infakazh2256364.shtml

---

## 10. 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-17 | 调研 OpenList 最新动态（v4.2.2、v4.1+ Docker 变更、治理对比）；完成 AList 卸载；本调研报告归档 |