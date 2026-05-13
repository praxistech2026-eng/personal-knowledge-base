# AI Center WIKI 索引

> 点击目录名跳转，点击路径可直接复制。

---

## 📁 目录结构总览

```
AI-Center/
├── 📂 services/        # 常驻进程服务
├── 📂 tools/          # 按需调用工具
├── 📂 platforms/      # 外部集成平台
├── 📂 infrastructure/ # 基础设施
├── 📂 docs/           # 系统文档
├── 📂 credentials/    # 敏感凭证
└── 📂 config/         # 配置文件
```

---

## 🔧 services — 常驻进程服务

| 服务 | 说明 | 路径 |
|------|------|------|
| [Hermes](./services/hermes/README.md) | 主 Agent 框架，决策层 | `services/hermes/` |
| [Hindsight](./services/hindsight/README.md) | 长期记忆与向量检索（PostgreSQL） | `services/hindsight/` |
| [SearXNG](./services/searxng/README.md) | 隐私搜索聚合引擎（Docker） | `services/searxng/` |
| [Self-Evolution](./services/self-evolution/README.md) | 自我进化优化（DSPy+GEPA） | `services/self-evolution/` |
| [Sessions-Backup](./services/sessions-backup/README.md) | 会话存档备份（热备/冷备/Hindsight） | `services/sessions-backup/` |
| [n8n](./services/n8n/README.md) | 工作流自动化 | `services/n8n/` |

---

## 🛠️ tools — 按需调用工具

| 工具 | 说明 | 路径 |
|------|------|------|
| [Whisper](./tools/whisper/README.md) | 本地语音识别（base 模型） | `tools/whisper/` |
| [Edge TTS](./tools/edge-tts/README.md) | 本地语音合成（zh-CN-XiaoxiaoNeural） | `tools/edge-tts/` |
| [Fal.ai](./tools/fal-ai/README.md) | FLUX 图像生成（余额不足，已暂停） | `tools/fal-ai/` |
| [Search Tools](./tools/search-tools/README.md) | 搜索工具矩阵（Jina/Crawl4AI/Scrapling/DuckDuckGo/Tavily） | `tools/search-tools/` |

---

## 🌐 platforms — 外部集成平台

| 平台 | 说明 | 路径 |
|------|------|------|
| [Feishu](./platforms/feishu/README.md) | 飞书消息集成 | `platforms/feishu/` |
| [WeChat](./platforms/wechat/README.md) | 微信消息集成 | `platforms/wechat/` |
| [MiniMax](./platforms/minimax/README.md) | 主模型提供商（M2.7） | `platforms/minimax/` |
| [Volcengine](./platforms/volcengine/README.md) | 备选模型（DeepSeek-V3.2 / Doubao-seed-2.0） | `platforms/volcengine/` |
| [OpenClaw](./platforms/openclaw/README.md) | 执行层 Agent（与 Hermes 共进程） | `platforms/openclaw/` |

---

## 🖥️ infrastructure — 基础设施

| 组件 | 说明 | 路径 |
|------|------|------|
| [Tailscale](./infrastructure/tailscale/README.md) | VPN 远程访问（节点：shin） | `infrastructure/tailscale/` |
| [Oracle Cloud](./infrastructure/oracle-cloud/README.md) | Oracle VPS（us-sanjose-1） | `infrastructure/oracle-cloud/` |

---

## 📄 docs — 系统文档

| 文档 | 说明 |
|------|------|
| [AI-Center-拓扑图](./AI-Center-拓扑图.md) | 系统全拓扑架构图 |
| [AI-Center-Agent-Team-Runtime-设计说明](./AI-Center-Agent-Team-Runtime-设计说明.md) | Agent 团队运行时设计 |
| [个人知识沉淀系统-设计文档](./个人知识沉淀系统-设计文档.md) | 知识输入→处理→审核→入库全链路 |
| [README](./README.md) | AI Center 总览 |
| [WIKI-索引](./WIKI-索引.md) | 本索引页 |

---

## 🔐 credentials — 敏感凭证

| 文件 | 说明 | 路径 |
|------|------|------|
| [系统凭证备忘录](./credentials/系统凭证备忘录.md) | 各平台 API 密钥与凭证 | `credentials/系统凭证备忘录.md` |

---

## ⚙️ config — 配置文件

| 文件 | 说明 | 路径 |
|------|------|------|
| [花云+Mitce+Webshare+Oracle场景优化版](./config/花云+Mitce+Webshare+Oracle场景优化版.yaml) | 场景配置 YAML | `config/花云+Mitce+Webshare+Oracle场景优化版.yaml` |

---

## 🗂️ 其他

| 项目 | 说明 | 路径 |
|------|------|------|
| [Skills System](./skills-system/README.md) | 技能系统（76 个已安装） | `skills-system/` |
| [Knowledge](../Knowledge/README.md) | 个人沉淀知识（Obsidian） | `Knowledge/` |

---

## 🚨 待处理问题

- [x] `session_archive.py` 路径错误 → 已修复（重定向到 ~/.hermes/sessions/）
- [x] `sessions-to-hindsight.py` cron 未执行 → 已配置
- [x] Mac Obsidian vault 同步状态未知 → Git Hook 已就位（`~/Desktop/PersonalKnowledge/.git/hooks/post-commit`）
- [ ] 个人知识沉淀系统：Mac 端 vault Git 同步需用户确认是否正常

---

## 📌 最近更新

- **2026-05-10** — WIKI 目录重构完成，按 services/tools/platforms/infrastructure/docs/credentials/config 分类
- **2026-05-10** — sessions-backup 三层备份系统上线（热备/Git冷备/Hindsight）
- **2026-05-11** — 新增 n8n 服务（工作流自动化，端口 5678）
- **2026-05-13** — 记忆控制面 9C 收口，拓扑图 / 运行时 / 个人知识设计已同步
