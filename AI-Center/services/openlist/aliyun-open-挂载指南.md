# 阿里云盘 Open 挂载指南

> 适用版本：OpenList v4.x（当前 v4.2.2）
> 创建日期：2026-06-18
> 状态：🟡 等用户拿到 refresh_token 后代填

---

## 0. 为什么推荐先挂这个

| 维度 | 阿里云盘 Open | 夸克 Cookie | 百度网盘中转 |
|---|---|---|---|
| **token 寿命** | ⭐⭐⭐⭐⭐ 自动续期，**几乎不维护** | ⭐⭐ 1-2 周必重抓 | ⭐⭐⭐ 数月 |
| **限速** | 普通 1-3 MB/s，**会员可达 100 MB/s** | 普通 100KB/s，SVIP 5-10MB/s | 普通 100-500KB/s |
| **驱动稳定性** | ⭐⭐⭐⭐⭐ OpenList 原生驱动 | ⭐⭐ 逆向接口 | ⭐⭐⭐ 中转 API |
| **挂载难度** | ⭐⭐ 容易（refresh_token 自动） | ⭐⭐⭐ Chrome 抓包 | ⭐⭐ api.oplist.org 工具 |
| **推荐度** | ⭐⭐⭐⭐⭐ **首选** | 备胎 | 次选 |

**结论**：**阿里云盘是 OpenList 挂载体验最好的第三方网盘**——token 自动续期、API 稳定、原生驱动完善。

---

## 1. refresh_token 拿法（关键步骤）

### 路线 A：api.oplist.org 工具（推荐，跟百度一样）

1. 手机装 **阿里云盘 App**（已有就跳过）
2. 浏览器打开 **https://api.oplist.org/**
3. 选 **"阿里云盘 Open"**
4. 页面里**勾选 "使用 OpenList 提供的参数"**（关键，免 client_id）
5. 点 **"获取 Token"** → 弹一个**二维码**
6. 用 **阿里云盘 App 扫这个二维码**（App 右上角 "+" → 扫一扫）
7. App 弹"AList / OpenList 申请授权" → 点**允许**
8. 网页**自动填入 refresh_token**（一长串字符，`122.xxx` 开头）
9. 复制整串 refresh_token 贴给 Agent

### 路线 B：手机 ES 文件浏览器抓

1. Android 装 **ES 文件浏览器** + 阿里云盘 App
2. ES 文件浏览器 → 添加网盘 → 阿里云盘 → 登录
3. Android 11+ 限制了其他 App 访问 `/Android/data/`，用 ES 文件浏览器进入：
   ```
   /Android/data/com.alicloud.databox/files/logs/trace/
   ```
4. 找最新日志文件 → 搜 `refreshToken` → 复制中间那串

**路线 A 比 B 快 10 倍**——推荐 A。

---

## 2. Agent 挂载步骤（refresh_token 给到我后）

我（Agent）会用 OpenList admin API 代填 storage：

```python
storage_payload = {
    "mount_path": "/alipan",
    "driver": "AliyundriveOpen",
    "cache_expiration": 365,        # 阿里云盘 Open 限频严，缓存长一点
    "addition": json.dumps({
        "drive_type": "resource",  # 不要选 backup
        "refresh_token": "<你给的 token>",
        "use_online_api": True,
        "api_url_address": "https://api.oplist.org/alicloud/renewapi",
        "alipan_type": "default",
        "remove_way": "trash",
        "order_by": "name",
        "order_direction": "ASC",
        "livp_download_format": "jpeg"
    })
}
POST /api/admin/storage/create
```

验证：`GET /api/fs/list?path=/alipan` 看是否返回真实文件。

---

## 3. 关键经验（踩过的坑）

- **不要选 `drive_type: backup`**——这是你手机自动备份的目录，文件乱七八糟
- **`use_online_api: true` 必备**——否则 storage 启动时校验 client_id 失败
- **`cache_expiration` 设 365 分钟**（6 小时）——阿里云盘 Open 限频严，缓存短了会反复触发 API 调用
- **`livp_download_format: jpeg`**——iPhone 实况照片下载成 jpeg（mov 格式跨平台播不了）
- **普通 token 限速**——如果想跑满速，开通阿里云盘会员（PC 端/移动端各 ¥15/月）

---

## 4. 挂载成功后

我会做的事：

1. Token 备份到 `~/workspace/services/openlist/data/alipan.token.bak` (chmod 600)
2. `.env` 登记 `OPENLIST_ALIPAN_REFRESH_TOKEN_BACKUP=...`
3. `/tmp` 临时文件清理
4. **更新 4 处档案**：
   - `services/openlist/README.md` 已挂载存储表加 `/alipan`
   - `docs/AI-Center-拓扑图.md` 端口表 + 更新日志
   - `docs/WIKI-索引.md` 待办项
   - **254 上的 Homepage** 加"阿里云盘 (via OpenList)"卡片

---

## 5. 重要警觉

| 风险 | 应对 |
|---|---|
| refresh_token 也可能因 OpenList API 限速触发风控 | 异常时去 api.oplist.org 重新走一遍 |
| 主账号被风控连带 | 用**专门小号**挂载，主号保持纯净使用 |
| 转存分享可能限速严重 | **不推荐**用 OpenList 做大流量分发 |

---

## 6. 验证清单

挂好后验证：

- [ ] OpenList 后台 → 管理 → 存储 → 看到 `/alipan`
- [ ] 点击 `/alipan` 能列出真实文件（不是空白或 500）
- [ ] 主页 http://192.168.2.249:5244 侧栏能看到 `/alipan`
- [ ] Homepage 面板 http://192.168.2.254:3000 有"阿里云盘"卡片

---

**下一步**：去 https://api.oplist.org/ 拿 refresh_token 贴给我。