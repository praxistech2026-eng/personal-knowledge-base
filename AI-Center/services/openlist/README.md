# OpenList

> 网盘聚合器（AList 的社区 fork）：把阿里云盘 / 百度网盘 / 夸克 / OneDrive / Google Drive 等 30+ 第三方网盘统一在一个 Web 入口，支持 WebDAV、离线下载、影音直链（302 重定向）。
>
> **2026-06-17 决策替换 AList**：项目易主 + 隐藏 telemetry → 迁移到 OpenList。详见 [`调研报告-OpenList.md`](./调研报告-OpenList.md)。

---

## 基础信息

| 属性 | 值 |
|------|-----|
| **类型** | Docker 容器（常驻进程） |
| **镜像** | `openlistteam/openlist:latest` |
| **版本** | v4.2.2（Commit b28208b，2026-05-25 build） |
| **容器名** | `openlist` |
| **运行模式** | `--user 0:0`（容器内以 root 跑，与原 AList 一致） |
| **监听端口** | `5244`（Web + WebDAV）+ `5245`（签名辅助） |
| **数据目录** | `/home/shin/workspace/services/openlist/data` |
| **宿主机挂载** | `~/workspace/services/openlist/data:/opt/openlist/data` |
| **运行机器** | 192.168.2.249（AI Center） |
| **访问地址** | http://192.168.2.249:5244 |
| **安装日期** | 2026-06-18 |
| **运行状态** | 🟢 运行中（替换原 AList） |

---

## 架构定位

```
AI Center (192.168.2.249)
└── OpenList (5244) ← 网盘聚合器 v4.2.2
        ├── 阿里云盘 Open（refresh_token）— 计划优先
        ├── 夸克网盘（Cookie）/ 夸克 TV（refresh_token）— 备胎
        ├── OneDrive / Google Drive（OAuth）— 计划主力
        ├── 百度网盘（refresh_token）
        └── 本地存储（如有）
                ↓
        统一 Web 入口 + WebDAV
                ↓
        接入 Homepage 面板
```

---

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub | https://github.com/OpenListTeam/OpenList |
| Releases | https://github.com/OpenListTeam/OpenList/releases |
| Docker Hub | https://hub.docker.com/r/openlistteam/openlist |
| 官方文档 | https://doc.oplist.org |
| Docker 安装指南 | https://doc.oplist.org/guide/installation/docker |

---

## 在本生态中的角色

**资源聚合层**。解决用户 100+ 微信群分散使用多个网盘的痛点：把多网盘挂载到一个统一入口，输出统一分享链接 + 资源索引 + 离线下载到挂载网盘。

**与 AList 的关系**：完全替代品（API/数据格式兼容），治理更透明、镜像架构更全（amd64+arm64）。

---

## 常用命令

```bash
# 查看状态
docker ps | grep openlist

# 查看初始密码（首次启动后，从日志抓）
docker logs openlist 2>&1 | grep "initial password"

# 重置密码（v3.25+ / v4.x 密码 hash 化，忘了只能重置）
docker exec -it openlist ./openlist admin random
# 或手动设置
docker exec -it openlist ./openlist admin set NEW_PASSWORD

# 查看日志
docker logs -f openlist --tail 100

# 升级（先看 release notes 是否有 Breaking Changes）
docker pull openlistteam/openlist:latest
docker stop openlist && docker rm openlist
# 重新运行（参数见下方 docker run）

# 数据备份
tar -czf openlist-data-$(date +%Y%m%d).tar.gz \
  /home/shin/workspace/services/openlist/data
```

### 完整 docker run 命令

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

---

## 部署过程记录（2026-06-18）

| 步骤 | 结果 |
|------|------|
| 1. 卸载 AList | ✅ 容器停止/删除、镜像删除、数据目录清理（sudo）、AI Center 档案清理、`.env` ALIST_ 清理 |
| 2. 调研 OpenList 最新动态 | ✅ 确认 v4.2.2 为最新稳定版；v4.1+ 移除 PUID/PGID 改用 `--user` |
| 3. 拉镜像 | ✅ `openlistteam/openlist:latest`（amd64 52MB，**比 AList 的 xhofe/alist 还多覆盖了 arm64**） |
| 4. 创建数据目录 | ✅ `/home/shin/workspace/services/openlist/data` |
| 5. 启动容器 | ✅ 5244 端口监听，HTTP 200，3 秒内 ready |
| 6. 初始密码 | `cO6XpnEC`（日志抓取） |
| 7. 重置强密码 | ✅ 20 位强密码 `7TSqNxZ0...6bzH`，写入 `~/.hermes/.env` 的 `OPENLIST_ADMIN_PASSWORD` |
| 8. 关 allow_mounted | ✅ false |
| 9. 关 allow_indexed | ✅ false |
| 10. allow_register | ✅ 默认即关（v4.2.2 字段为 None 即视为关） |
| 11. LAN 访问 | ✅ http://192.168.2.249:5244 200 OK |
| 12. 数据持久化 | ✅ config.json + data.db 落盘 |
| 13. 用户改密码 | ⚠️ 用户将密码改为 `67748299`（与 SSH/OpenClaw API Key/PVE 密码相同，**密码重用风险已记入 credentials/系统凭证备忘录.md**） |
| 14. 挂载夸克网盘（Cookie 方案） | ✅ 挂载点 `/quark`，Cookie 写入 AList + 备份到 .env |

---

## v4.1+ Docker 部署关键变更（重要经验）

1. **PUID/PGID 已废弃**（v4.1.0+）
   - 老 AList 命令里的 `-e PUID=0 -e PGID=0` **不要再用**
   - 改用 `--user 0:0`（容器内 root）或宿主机目录 `chown 1001:1001` 用容器内置 openlist 用户
2. **环境变量无需前缀**
   - OpenList 镜像默认带 `--no-prefix`，直接写 `OPENLIST_ADMIN_PASSWORD` 即可
3. **二进制名是 `openlist` 不是 `alist`**
   - 容器内命令：`./openlist admin set NEW_PASSWORD`
4. **arm64 终于支持**
   - OpenList 镜像同时有 amd64 + arm64 多架构
   - AList 时代 arm64 用户必须用 alist666/alist（只有 arm64，amd64 跑不了）—— 这个问题消失了

---

## 凭证与配置

| 项 | 值 | 备注 |
|----|-----|------|
| admin 用户名 | `admin` | |
| admin 密码 | 完整值在 `~/.hermes/.env` 的 `OPENLIST_ADMIN_PASSWORD` | 20 位强密码，部署时重置 |
| JWT 签名密钥 | 部署后未改（默认值） | 建议后续在管理 → 设置 → 站点签名密钥 改 |
| refresh_token（各网盘） | 部署后填 | 各挂载网盘独立 token |

> 完整凭证清单：见 `credentials/系统凭证备忘录.md` 的"OpenList"段

---

## 已挂载存储

| 挂载路径 | 网盘类型 | storage id | 状态 | 备注 |
|---------|---------|-----------|------|------|
| /quark | 夸克网盘（Cookie） | 1 | 🟢 运行中 | 2026-06-18 用户抓包挂载，列出 7 个真实文件夹/文件 |
| /baidu | 百度网盘（APIAddress 中转） | 5 | 🟢 运行中 | 2026-06-18 挂载，列根目录 64 项真实文件/文件夹 |
| /alipan | 阿里云盘 Open（JWT token + APIAddress 中转） | 6 | 🟢 运行中 | 2026-06-18 挂载，列根目录 1 项「来自分享」；token 寿命长，自动续期 |
| /onedrive | OneDrive | — | 🟡 待挂 | OAuth 一键登录 |

---

## 重要经验

- **v4.1+ 别用 PUID/PGID**：会被忽略，且可能引发权限错误；改用 `--user 0:0`
- **API 路径不变**：OpenList 完全兼容 AList 的 API（`/api/admin/setting/save`、`/api/auth/login` 等）
- **数据可平滑迁移**：理论上直接挂载 AList 的 `data/` 目录就能用（同 fork），但本次是新部署所以未迁移
- **不接的网盘就别装**：没必要为 `-aio` 镜像付 100MB 体积代价，等真要用 aria2/ffmpeg 时再换 tag

---

## 风险与注意事项

- **OpenList Fork 仅 1 年**（2025-06 起），部分 edge case 还在暴露，生产前先跑两周观察
- **夸克网盘驱动**：逆向接口，限速严，Cookie 频繁失效——**任何工具都救不了**（包括 AList）
- **AGPL-3.0**：商用必须开源或付费（个人用无影响）
- **大版本升级要看 release notes**：v4.2.0 已含 Breaking Changes

---

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-17 | 调研 OpenList，确认 v4.2.2 为最新稳定版；调研报告归档 |
| 2026-06-17 | 卸载 AList（容器/镜像/数据/.env/AI Center 档案全清） |
| 2026-06-18 | ✅ 部署 OpenList v4.2.2：20 位强密码写 .env；3 项访客权限关；端口 5244 LAN 200 OK；数据落盘 |
| 待执行 | 挂载第一个网盘（推荐先挂阿里云盘 Open），接入 Homepage 面板 |