# AI Center 拓扑图

> 本笔记记录 AI Center 所有部署服务、软件、凭证和拓扑关系。
> 新增部署时更新本文档。格式：[[AI-Center-拓扑图]]

---

## 整体架构

```
                         ┌─────────────────────────────────────────────────────┐
                         │              AI Center (localhost)                  │
                         │                                                      │
                         │   ┌──────────────────┐      ┌──────────────────┐  │
                         │   │  hermes-gateway   │      │  hermes-webui    │  │
                         │   │  (systemd service)│      │  (Python server) │  │
                         │   │                   │      │                  │  │
                         │   │  ports:           │      │  port: 8080      │  │
                         │   │  18789 (gateway)  │      │  → LAN可访问     │  │
                         │   │  18791 (api)      │      │                  │  │
                         │   │  3334 (internal)   │      │                  │  │
                         │   └────────┬─────────┘      └──────────────────┘  │
                         │            │                                       │
                         │            │ 共享 openclaw-gateway (同一进程)        │
                         │            │                                       │
                         │   ┌────────▼─────────┐                              │
                         │   │  openclaw-gateway │                             │
                         │   │  port: 18789 (共用) │                            │
                         │   └────────┬─────────┘                              │
                         │            │                                        │
                         └────────────┼────────────────────────────────────────┘
                                      │
                         ┌────────────▼────────────┐
                         │     外部平台              │
                         │                          │
                         │  ┌─────────┐  ┌────────┐ │
                         │  │ 飞书    │  │ 微信   │ │
                         │  │ Feishu │  │ WeChat │ │
                         │  └─────────┘  └────────┘ │
                         └─────────────────────────┘

AI Provider (外部):
  ┌─────────────┐     ┌──────────────────┐
  │ MiniMax-CN  │ ←── │ MiniMax-M2.7    │  主模型 (primary)
  │ (api.minimaxi.com/anthropic) │
  └─────────────┘     └──────────────────┘
  ┌─────────────┐     ┌──────────────────┐
  │ Volcengine  │ ←── │ DeepSeek-V3.2    │  备选
  │ ARK         │     │ Doubao-seed-2.0  │
  │ (ark.cn-beijing.volces.com) │        │  备选
  └─────────────┘     └──────────────────┘

内存/知识 (可选扩展):
  ┌──────────┐  ┌────────┐  ┌─────────┐  ┌───────────┐
  │ Hindsight│  │ mem0   │  │super mem│  │Hermes内置 │
  │(未部署)  │  │(未部署)│  │(未部署) │  │ memory-core│
  └──────────┘  └────────┘  └─────────┘  └───────────┘
```

---

## 服务详情

### 1. hermes-gateway（主网关）

| 属性 | 值 |
|------|-----|
| **类型** | systemd --user 服务 |
| **服务名** | `hermes-gateway.service` |
| **进程** | `openclaw-gateway` (与 OpenClaw 共用进程) |
| **PID** | 486095 |
| **监听端口** | `18789` (gateway), `18791` (API server), `3334` (internal RPC) |
| **LAN 访问** | ✅ `http://<本地IP>:18789` 可从局域网访问 |
| **启动方式** | `systemctl --user start hermes-gateway.service` |
| **日志** | `~/.hermes/logs/gateway.log` |
| **配置文件** | `~/.hermes/config.yaml` |

> ⚠️ **注意**: `openclaw-gateway` 和 `hermes-gateway` 实为同一进程，由 OpenClaw 框架启动。两个名字混用是正常现象。

---

### 2. hermes-webui（Web UI）

| 属性 | 值 |
|------|-----|
| **类型** | Python 服务 (直接运行) |
| **进程** | `/home/shin/.hermes/hermes-agent/.venv/bin/python /home/shin/hermes-webui/server.py` |
| **PID** | 265851 |
| **监听端口** | `8080` |
| **LAN 访问** | ✅ `http://<本地IP>:8080` 可从局域网访问 |
| **Web 框架** | 第三方 Web UI (非 Hermes 原生) |
| **sessions 目录** | `~/.hermes/webui/sessions/` |

> 💡 **备注**: hermes-webui 是第三方增强界面，连接本地 Hermes Gateway。

---

### 3. SearXNG（内网搜索）

| 属性 | 值 |
|------|-----|
| **类型** | 元搜索聚合引擎 |
| **监听端口** | `8787` (TCP) |
| **访问地址** | `http://localhost:8787` |
| **用途** | Hermes 的 web search 工具后端 |
| **配置** | `~/.hermes/config.yaml` 中 tools.web.search.provider=s`earxng` |

> ⚠️ SearXNG 默认配置可能允许外部访问，建议配合防火墙或认证使用。

---

### 4. Feishu（飞书）集成

| 属性 | 值 |
|------|-----|
| **类型** | OpenClaw 平台插件 (`channels.feishu`) |
| **插件配置路径** | `~/.openclaw/feishu/` |
| **App ID** | `cli_a951cc68c0789cee` |
| **App Secret** | `gUC1mThDY8JklxkPV3czGcbSq4GLslAb` |
| **启用状态** | ✅ 已启用 |
| **订阅事件** | `im.message.receive_v1` |
| **用户 ID 类型** | `open_id`（格式：`ou_xxx`） |

> 🔑 **凭证信息**（请勿外泄）:
> - App ID: `cli_a951cc68c0789cee`
> - App Secret: `gUC1mThDY8JklxkPV3czGcbSq4GLslAb`

---

### 5. WeChat（微信）集成

| 属性 | 值 |
|------|-----|
| **类型** | OpenClaw NPM 插件 (`@tencent-weixin/openclaw-weixin`) |
| **插件路径** | `~/.openclaw/extensions/openclaw-weixin` |
| **版本** | 2.1.8 |
| **安装时间** | 2026-04-17 |
| **OpenClaw 配置** | `~/.openclaw/openclaw.json` → `plugins.entries.openclaw-weixin` |
| **Account ID** | `1152b1001190-im-bot` |
| **Token** | `c3564e...e56a`（完整值见 ~/.hermes/.env） |

> 🔑 **凭证信息**（请勿外泄）:
> - Account ID: `1152b1001190-im-bot`
> - Token: 完整值在 `~/.hermes/.env` 的 `WEIXIN_TOKEN`

---

### 6. MiniMax-CN（主模型提供商）

| 属性 | 值 |
|------|-----|
| **模型** | MiniMax-M2.7 |
| **提供商** | MiniMax-CN Portal |
| **API Endpoint** | `https://api.minimaxi.com/anthropic` |
| **API Mode** | `anthropic-messages` |
| **Context Window** | 204,800 tokens |
| **Max Output** | 131,072 tokens |
| **Reasoning** | ✅ 启用 |
| **输入成本** | $0.3 / 1M tokens |
| **输出成本** | $1.2 / 1M tokens |
| **缓存读取** | $0.06 / 1M tokens |
| **缓存写入** | $0.375 / 1M tokens |

> 🔑 **凭证信息**（请勿外泄）:
> - API Key: 完整值在 `~/.hermes/.env` 的 `MINIMAX_CN_API_KEY`
> - Base URL: `https://api.minimaxi.com/anthropic`

---

### 7. Volcengine ARK（备选模型提供商）

| 属性 | 值 |
|------|-----|
| **类型** | OpenClaw 插件 (`volcengine`) |
| **API Endpoint** | `https://ark.cn-beijing.volces.com/api/coding/v3` |
| **API Mode** | `openai-completions` |
| **内置模型** | ark-code-latest（自动路由）、DeepSeek-V3.2、Doubao-seed-2.0-code/pro |
| **成本** | 免费（火山引擎编程计划） |

> 🔑 **凭证信息**（请勿外泄）:
> - API Key: 完整值在 `~/.hermes/.env` 的 `ARK_API_KEY`
> - API Key (部分): `dd94ff...7817`

---

## Skills 系统

### agency-agents（角色库）

| 属性 | 值 |
|------|-----|
| **位置** | `~/.hermes/skills/agency-agents/` |
| **角色数量** | 211 个 |
| **索引文件** | `~/.hermes/skills/agency-agents/SKILL.md` (8.2 KB) |
| **角色目录** | `~/.hermes/skills/agency-agents/agents/` (211 个子目录) |
| **主要分类** | marketing (小红书、抖音、B站等)、engineering (飞书集成等) |
| **单角色激活** | `/skill agency-agents/agents/marketing/xiaohongshu-operator` |
| **父 Skill** | `agency-agents`（汇总索引） |
| **安装日期** | 2026-04-28 |

> 💡 使用 agency-agents 角色前需确认该角色对应当前对话上下文是否合适。

### 内置 Skills

| 属性 | 值 |
|------|-----|
| **总数** | 38 个内置 + 211 agency-agents = 250 个 |
| **包含范围** | GitHub、Terminal、Browser、Obsidian、飞书、微信、Web 等 |
| **用户安装的** | `agency-agents` (211角色) |

---

## 内存/知识系统

### Hermes 内置 Memory（已激活）

| 属性 | 值 |
|------|-----|
| **类型** | 插件: `memory-core` |
| **长期记忆目录** | `~/HermesKnowledge/memory/` |
| **结构** | logs/、projects/、groups/、system/ |
| **记忆文件** | `~/HermesKnowledge/memory/system/MEMORY.md` |
| **Obsidian 同步** | ✅ `hn` 命令输入知识，`ha` 命令应用合并 |

### 可选扩展内存（未部署）

| 服务 | 状态 | 说明 |
|------|------|------|
| Hindsight | ❌ 未部署 | 三层记忆架构（World Facts/Experiences/Mental Models），需 Docker |
| mem0 | ❌ 未部署 | 向量+图谱混合记忆 |
| SuperMemory | ❌ 未部署 | 浏览器增强记忆 |
| Honcho | ❌ 未部署 | 本地内存服务 |

> 💡 如需升级到外部记忆系统，参考: [[AI-Center-拓扑图]] 内 Hindsight 章节。

---

## 搜索工具矩阵（已配置）

| 工具 | 版本 | 类型 | 用途 |
|------|------|------|------|
| Jina Reader | API | Skill（`jina-reader`） | 单页精准抓取，干净 Markdown |
| Crawl4AI | 0.8.6 | Skill（`crawl4ai`） | 大规模批量深度抓取，异步并行 |
| Scrapling | 0.2.99 | hermes tools + pip | 复杂反爬，多引擎自适应解析 |
| CamoFox | 0.4.11 | hermes tools + pip | 高匿名隐身浏览器，指纹隐藏 |

### Jina Reader
- API Endpoint: `https://r.jina.ai/<url>`
- 脚本: `~/scripts/jina-read`
- 认证: Bearer Token（`jina_` 开头）
- 定位: 单页快速抓取，内容质量高

### Crawl4AI
- Python 包: `crawl4ai` v0.8.6
- 前置要求: `playwright install chromium`
- 定位: 批量 URL、深层爬取、JS 渲染、LLM 过滤

### Scrapling
- Python 包: `scrapling` v0.2.99
- 引擎: Fetcher(httpx) / StealthyFetcher(Camoufox) / PlayWrightFetcher(Playwright)
- 定位: 复杂反爬场景，自适应解析

### CamoFox
- Python 包: `camoufox` v0.4.11
- CLI: `~/.local/bin/camoufox`
- 定位: 最严格反爬，完整浏览器指纹隐藏

---

## 网络与安全

### 端口汇总

| 端口 | 服务 | LAN 可访问 | 建议 |
|------|------|-----------|------|
| 22 | SSH | ✅ | 使用密钥登录 |
| 18789 | Hermes Gateway | ✅ | ⚠️ 无认证，建议内网使用 |
| 18791 | Hermes API Server | ✅ | ⚠️ API Key: `67748299` |
| 3334 | Hermes Internal RPC | ❌ 本地 | - |
| 8080 | hermes-webui | ✅ | ⚠️ 无认证，建议内网使用 |
| 8787 | SearXNG | ✅ | ⚠️ 搜索服务暴露，配置认证 |
| 631 | CUPS 打印 | ✅ | 可关闭 |

### API Server

| 属性 | 值 |
|------|-----|
| **启用** | ✅ `API_SERVER_ENABLED=true` |
| **Key** | `67748299` |
| **端口** | 18791 |
| **用途** | 提供给 hermes-webui 等外部调用 |

---

## 部署检查清单

新增服务时，更新本文档：

- [ ] 服务类型和名称
- [ ] 进程/PID 信息
- [ ] 监听端口
- [ ] 配置文件路径
- [ ] 凭证信息（如有）
- [ ] 依赖关系（谁依赖谁）
- [ ] LAN 访问范围
- [ ] 更新拓扑图 ASCII

---

## 更新日志

| 日期 | 操作 |
|------|------|
| 2026-04-28 | 初始创建本文档，记录 hermes-gateway、hermes-webui、SearXNG、Feishu、WeChat、模型配置 |
| 2026-05-02 | 新增搜索工具矩阵：Jina Reader（Skill）、Crawl4AI（Skill）、Scrapling（pip）、CamoFox（pip） |

---

*本文档由 Hermes Agent 自动生成维护*
