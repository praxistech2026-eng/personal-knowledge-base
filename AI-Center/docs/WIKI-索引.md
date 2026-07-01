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
| [Hermes](../services/hermes/README.md) | 主 Agent 框架，决策层 | `services/hermes/` |
| [Hindsight](../services/hindsight/README.md) | 长期记忆与向量检索（PostgreSQL） | `services/hindsight/` |
| [SearXNG](../services/searxng/README.md) | 隐私搜索聚合引擎（Docker） | `services/searxng/` |
| [Self-Evolution](../services/self-evolution/README.md) | 自我进化优化（DSPy+GEPA） | `services/self-evolution/` |
| [Sessions-Backup](../services/sessions-backup/README.md) | 会话存档备份（热备/冷备/Hindsight） | `services/sessions-backup/` |
| [n8n](./services/n8n/README.md) | 工作流自动化 | `services/n8n/` |
| [OpenList](./services/openlist/README.md) | 网盘聚合器（AList 社区 fork，无 telemetry，治理透明） | `services/openlist/` |
---

## 🛠️ tools — 按需调用工具

| 工具 | 说明 | 路径 |
|------|------|------|
| [Whisper](../tools/whisper/README.md) | 本地语音识别（base 模型） | `tools/whisper/` |
| [Edge TTS](../tools/edge-tts/README.md) | 本地语音合成（zh-CN-XiaoxiaoNeural） | `tools/edge-tts/` |
| [Fal.ai](../tools/fal-ai/README.md) | FLUX 图像生成（余额不足，已暂停） | `tools/fal-ai/` |
| [Search Tools](../tools/search-tools/README.md) | 搜索工具矩阵（Jina/Crawl4AI/Scrapling/DuckDuckGo/Tavily） | `tools/search-tools/` |

---

## 🌐 platforms — 外部集成平台

| 平台 | 说明 | 路径 |
|------|------|------|
| [Feishu](../platforms/feishu/README.md) | 飞书消息集成 | `platforms/feishu/` |
| [WeChat](../platforms/wechat/README.md) | 微信消息集成 | `platforms/wechat/` |
| [MiniMax](../platforms/minimax/README.md) | 主模型提供商（M3 / M2.7 / speech） | `platforms/minimax/` |
| [Agnes](../platforms/agnes/README.md) | 多模态补位厂商（text/image/video 已实测） | `platforms/agnes/` |
| [Volcengine](../platforms/volcengine/README.md) | 备选模型（DeepSeek-V3.2 / Doubao-seed-2.0） | `platforms/volcengine/` |
| [OpenClaw](../platforms/openclaw/README.md) | 执行层 Agent（与 Hermes 共进程） | `platforms/openclaw/` |

---

## 🖥️ infrastructure — 基础设施

| 组件 | 说明 | 路径 |
|------|------|------|
| [家庭网络 / HTPC](../infrastructure/home-network/README.md) | HTPC、PVE、路由、旁路由、NAS、交换机等家庭网络总索引（待盘点） | `infrastructure/home-network/` |
| [Tailscale](../infrastructure/tailscale/README.md) | VPN 远程访问（节点：shin） | `infrastructure/tailscale/` |
| [NovixLink](../infrastructure/novixlink/README.md) | NovixLink VPS（替代原 Praxis + Oracle Cloud，唯一境外 VPS） | `infrastructure/novixlink/` |

---

## 📄 docs — 系统文档

| 工具 | 说明 |
|------|------|
| [AI-Center-拓扑图](./AI-Center-拓扑图.md) | 系统全拓扑架构图 |
| [AI-Center-拓扑重画原则](./AI-Center-拓扑重画原则.md) | 拓扑分层、关系表达、重画硬性规则 |
| [AI-Center-结构重构提案](./AI-Center-结构重构提案.md) | 目录结构规划、职责边界、确认后的目录决策 |
| [AI-Center-Agent-Team-Runtime-设计说明](./AI-Center-Agent-Team-Runtime-设计说明.md) | Agent 团队运行时设计 |
| [个人知识沉淀系统-设计文档](./个人知识沉淀系统-设计文档.md) | 知识输入→解析→归一化→编译入库的正式基线 |
| [知识摄入解析层与统一内容包规范](./知识摄入解析层与统一内容包规范.md) | 解析层职责、Canonical Envelope、frontmatter 映射、失败兜底规范 |
| [知识摄入样例验证-2026-06-11](./知识摄入样例验证-2026-06-11.md) | 基于真实 _staging 卡片的结构验证与差距结论 |
| [模型调用策略-设计文档](./模型调用策略-设计文档.md) | Q/C/P 三维评价体系、任务分类、复杂度/价值判断、LiteLLM 路由架构 |
| [模型调用策略-使用说明书](./模型调用策略-使用说明书.md) | 用户视角快速上手、日常场景示例、手动干预方法、故障处理 |
| [服务档案管理方法论](./服务档案管理方法论.md) | 新增服务时的归档标准、模板、漏洞与流程 |
| [AI-Center-巡检总控](./AI-Center-巡检总控.md) | 统一巡检总控：资源 / 服务 / 门户 / 数据 / 档案库 / 审计 |
| [AI-Center-档案库总则](./AI-Center-档案库总则.md) | 档案库最高执行规范：信息分层、增删改、巡检、告警、经验沉淀 |
|| [AI-Center-档案库V1](./AI-Center-档案库V1.md) | 档案库当前执行版本：规则、模板、任务、边界、流程 |
|| [模板索引](./模板索引.md) | 问题 / 经验 / 变更 / 巡检 / 服务 README 模板总入口 |
|| [AI-Center-档案库整理计划](./AI-Center-档案库整理计划.md) | 这次整理的执行方案、分阶段路线、用户配合方式 |
|| [LiteLLM-健康快照-2026-06-15](./LiteLLM-健康快照-2026-06-15.md) | 修复前后 26→16 model 健康状态对比、Token Plan 实测能力 |
|| [Agnes-LiteLLM-验证-2026-06-21](./Agnes-LiteLLM-验证-2026-06-21.md) | Agnes 多模态注册纠偏、真实请求验证与经验沉淀 |
|| [MiniMax-TokenPlan-调研-2026-06-15](./MiniMax-TokenPlan-调研-2026-06-15.md) | MiniMax 2026 plan 变化、Token Plan 实测 8 个 model 列表、接入方案 |
|| [MiniMax-LiteLLM-接入复盘](./MiniMax-LiteLLM-接入复盘-2026-06-22.md) | MiniMax 当前结果复盘：LiteLLM 只保留文本 / 语音注册面，生成类能力桥接优先 |
|| [LLM-模型资源底表](./LLM-模型资源底表.md) | 厂商 → 模型/能力/MCP/插件 的可查询底表，含当前接入状态与未接入原因 |
|| [Bailian-LiteLLM-接入复盘](./Bailian-LiteLLM-接入复盘-2026-06-22.md) | Bailian 当前结果复盘：Token Plan 团队版已接入，文本主链路可用，生成类能力桥接优先 |
|| [AI-Center-阶段执行提示词](./AI-Center-阶段执行提示词.md) | 7 阶段重构计划、每阶段提示词、验收标准 |
| [AI-Center-架构视图说明](./AI-Center-架构视图说明.md) | 多视图架构说明：6 层架构 / 5 个视图 / 中台与项目边界 / 主归类规则 |
| [AI-Center-能力地图模板](./AI-Center-能力地图模板.md) | 能力地图字段定义与更新规则 |
| [AI-Center-项目组合表模板](./AI-Center-项目组合表模板.md) | 项目优先级判断与组合管理模板 |
| [AI-Center-依赖矩阵模板](./AI-Center-依赖矩阵模板.md) | 耦合关系显式化模板 |
| [AI-Center-项目状态卡模板](./AI-Center-项目状态卡模板.md) | 项目续跑快照模板与 Restart Summary |

| [operations/变更流程](../operations/变更流程.md) | 新增、升级、换 key、下线、归档的最小闭环 |
| [homepage/README](../homepage/README.md) | Homepage 门户配置、services.yaml / bookmarks.yaml |
| [README](./README.md) | AI Center 总览 |
| [WIKI-索引](./WIKI-索引.md) | 本索引页 |

---

## 🔐 credentials — 敏感凭证

| 文件 | 说明 | 路径 |
|------|------|------|
| [系统凭证备忘录](../credentials/系统凭证备忘录.md) | 各平台 API 密钥与凭证 | `credentials/系统凭证备忘录.md` |
| [LLM 厂商配置基线](../credentials/LLM-厂商配置基线.md) | 各厂商套餐 / 模型 / 端点基线 | `credentials/LLM-厂商配置基线.md` |
| [LiteLLM 模型配置方法](../credentials/LiteLLM-模型配置方法.md) | LiteLLM 统一模型网关配置 / health-check 速查 | `credentials/LiteLLM-模型配置方法.md` |
| [LLM 模型可用性快照](../credentials/LLM-模型可用性快照-2026-05-20.md) | 当前模型可用性实测快照 | `credentials/LLM-模型可用性快照-2026-05-20.md` |

---

## ⚙️ config — 配置文件

| 文件 | 说明 | 路径 |
|------|------|------|
| [花云_Mitce_Webshare_NovixLink场景优化版](../config/花云_Mitce_Webshare_NovixLink场景优化版.yaml) | OpenClash 主路由配置（链式版：AI 主落地 dialer-proxy: 🇺🇸 美国-故转，2026-06-20 主用） | `config/花云_Mitce_Webshare_NovixLink场景优化版.yaml` |
| [花云_Mitce_Webshare_NovixLink场景优化版_直连](../config/花云_Mitce_Webshare_NovixLink场景优化版_直连.yaml) | 直连版（AI 主落地无 dialer-proxy，用于对比测试直连 vs 链式） | `config/花云_Mitce_Webshare_NovixLink场景优化版_直连.yaml` |

---

## 🗂️ 其他

| 项目 | 说明 | 路径 |
|------|------|------|
| [Skills System](../skills-system/README.md) | 技能系统（76 个已安装） | `skills-system/` |
| [Knowledge](../Knowledge/README.md) | 个人沉淀知识（Obsidian） | `Knowledge/` |

---

## 🚨 待处理问题

- [x] `session_archive.py` 路径错误 → 已修复（重定向到 ~/.hermes/sessions/）
- [x] `sessions-to-hindsight.py` cron 未执行 → 已配置
- [x] Mac Obsidian vault 同步状态未知 → Git Hook 已就位（`~/Desktop/PersonalKnowledge/.git/hooks/post-commit`）
- [ ] 个人知识沉淀系统：Mac 端 vault Git 同步需用户确认是否正常
- [ ] OpenList 部署：🟢 v4.2.2 运行中 + 已挂载 **/quark**（夸克 Cookie）+ **/baidu**（百度 APIAddress 中转，64 项）+ **/alipan**（阿里云盘 Open JWT token，1 项"来自分享"）。下一步：挂 OneDrive（OAuth 一键）；**Homepage 254 live 同步完成** ✅ |

---

## 📌 最近更新

- **2026-05-10** — WIKI 目录重构完成，按 services/tools/platforms/infrastructure/docs/credentials/config 分类
- **2026-05-10** — sessions-backup 三层备份系统上线（热备/Git冷备/Hindsight）
- **2026-05-11** — 新增 n8n 服务（工作流自动化，端口 5678）
- **2026-06-04** — 调研 AList 网盘聚合器，输出调研报告 + 服务 README；建立《服务档案管理方法论》明确归档标准
- **2026-05-13** — 记忆控制面 9C 收口，拓扑图 / 运行时 / 个人知识设计已同步
