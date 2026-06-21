# AI Center 档案库整理计划

> 目标：把 AI Center 档案库收敛成一套**可核验、可维护、可自动化**的管理体系。
> 最高约束：`[AI-Center-档案库总则](./AI-Center-档案库总则.md)`；本计划是执行方案，不高于总则。
> 原则：**先核实，再修改；能自动化就不让人手重复；无法核实就保留原样。**

> 范围：AI Center 现在按“家庭 AI 中枢”定义，包含 AI 主机、HTPC、家庭网络（PVE / 路由 / 旁路由 / 交换 / NAS 等）以及其上运行的全部服务与入口。

---

## 1. 这 16 条是否合理

结论：**合理，且完整度足够高。**

它们不是 16 条彼此独立的“文档清单”，而是 4 层结构：

1. **文档链路**：先把服务入口、索引、拓扑、总览、凭证连起来。
2. **运行核验**：再确认服务真实状态、端口、数据目录、健康检查。
3. **运营联动**：把主页、备份、容灾、告警接起来。
4. **变更纪律**：最后把记录、核验、回滚、自动化固化成流程。

这套结构的效率高，因为它覆盖了“新增服务 → 验证服务 → 维护服务 → 下线服务”的完整闭环，避免文档散落成一堆孤岛。

### 2.1 这次整理要先补的三件事

- **Homepage 状态呈现**：确认是“配置层有状态、视觉层没显式呈现”，还是需要另做状态页 / 板式改造。
- **凭证总册完整度**：把能核实的全值补齐；拿不到全值的，统一标明来源文件和待核实原因，不再用省略号伪装完整。
- **范围扩展入档**：把 HTPC 与家庭网络服务纳入同一套索引、拓扑、Homepage 和巡检规则。

---

## 2. 16 条规则梳理

### A. 文档链路（1-6）

1. 新增任何服务，先建 `services/<name>/README.md`；没有 README，就不算完成归档。
2. 复杂项目才写调研/选型报告；简单项目只保留 README + 变更记录。
3. `docs/WIKI-索引.md` 必须同步，保证能从索引跳到服务。
4. `docs/AI-Center-拓扑图.md` 必须同步，保证拓扑和现实一致。
5. `docs/README.md` 必须同步，保证总览表可一眼扫到。
6. `credentials/系统凭证备忘录.md` 必须同步；完整值优先留在原始凭证源（如 `~/.hermes/.env`、`workspace/litellm/.env`、`auth.json`），文档里只写变量名/前缀/用途或来源。

### B. 运行核验（7-10）

7. README 基础信息表必须写全：类型、端口、数据目录、运行机器、访问地址、安装日期、状态。
8. 状态必须由实机核验，不用感觉写“运行中”；至少确认端口 / 进程 / 容器中的一个。
9. 数据目录和持久化路径必须核验，不能让“写着落盘，实际没挂载”混过去。
10. 健康检查基线必须存在：能 curl / 能查端口 / 能看容器状态，至少有一个明确判据。

### C. 运营联动（11-13）

11. WIKI、拓扑、总览 README 三处必须一起改，避免单点漂移。
12. 能接 Homepage 就接；至少给一个统一入口面板，别让服务散成一地链接。
13. 备份 / 容灾 / 告警必须接入；优先自动化通知，微信只做最后一跳，不做人肉中继。

### D. 变更纪律（14-16）

14. 每次变更都要写迭代记录，尤其是升级、改端口、换镜像、换凭证。
15. 无法核实的信息保留既有内容，不猜、不补、不硬改。
16. 新增服务的最简动作固定为：`README → 凭证 → WIKI → 拓扑 → 总览 → 健康/备份`；其余步骤尽量自动化。

---

## 3. 整理目标

这次整理不是“补文档”，而是做五件事：

- **把范围做大**：所有 IT 相关信息都纳入，包括账号、域名、证书、密钥、设备、服务、接口、配置、迁移痕迹。
- **把标准写死**：以后新增服务不再临时发挥。
- **把状态对齐**：文档只写已经核实的事实。
- **把过程留痕**：调研、讨论、设置思路、试错过程都要沉淀，后续接手的人拿到的是全过程，不只是结论。
- **把问题沉淀**：所有已解决和未解决的问题都要记录下来，写清现象、结论、未解点和后续动作，持续沉淀成经验库。
- **把动作最小化**：用户只做必要输入，其余尽量自动完成，能自动入库的就自动入库。

---

## 4. 现阶段整理计划

### 阶段 1：标准固化

已完成：
- `docs/README.md` 增加 16 条管理规则
- `docs/USAGE_MANUAL-标准.md` 建立统一使用手册标准
- `docs/WIKI-索引.md` 增加标准入口
- `docs/服务档案管理方法论.md` 升级为统一方法论；可复制模板入口统一见 `docs/模板索引.md`
- `docs/AI-Center-档案库总则.md` 建立为最高执行规范

目标：
- 让“什么叫归档完成”有唯一答案
- 让“服务 README 必须写什么”有固定格式

### 阶段 2：现有服务收口

已完成：
- Hermes
- Hindsight
- SearXNG
- n8n
- OpenList
- sessions-backup
- self-evolution

处理内容：
- 为每个服务补 `USAGE_MANUAL`
- 统一健康检查、备份、告警、恢复字段
- 保留无法核实的字段为“未核实 / 未接入 / 待核实”
- 把账号 / 域名 / 证书 / 密钥 / 接口 / 设置思路也纳入收口，而不是只收服务本体

### 阶段 3：实机核验

需要持续做的事：
- 核对服务是否真的在跑
- 核对端口、进程、容器
- 核对数据目录是否真实存在
- 核对服务文档是否和现实一致

原则：
- 能用 `curl`、`ss`、`ps`、`docker ps` 验证的，就不要猜
- 验不出来的，先保留原文，不强改

### 阶段 4：运营自动化

已落地：
- `~/.hermes/scripts/ai-center-backup-watchdog.py`：备份变化检测，成功时静默，有变化才汇报
- `~/.hermes/scripts/ai-center-health-watchdog.py`：核心服务健康巡检 + 备份新鲜度检查，异常时告警
- `AI Center 备份巡检` / `AI Center 健康告警`：小时级 no-agent cron 任务

仍需继续接起来的事：
- 失败告警统一通知到微信，采用 C 级模板：问题是什么 / 影响什么 / 建议下一步怎么做 / 是否需要人工介入
- 新服务接入自动化模板
- IT 新信息自动入库：账号、域名、证书、密钥、接口、配置、调研结论、设置思路都尽量在发现后自动沉淀
- 自动入库入口优先级：A. 文件/目录监听 → B. 消息入口 → C. 网页/浏览器剪藏
- 调研/讨论留痕：不仅存最终结论，也存关键过程、取舍理由和已验证假设
- 问题沉淀：所有已解决和未解决的问题都要记录，形成可检索的经验库；每条至少写现象、结论、未解点、后续动作

### 阶段 5：Homepage 状态结构化

已落地：
- `homepage-services.yaml` / `homepage-bookmarks.yaml` 增加 `status` 与 `probe` 字段
- 探针类型三档：`localhost`（127.0.0.1）/ `lan`（LAN 内网入口）/ `tailnet`（Tailscale 入口）/ `external`（不探）
- 新增 `~/.hermes/scripts/homepage-link-watchdog.py`：扫两个 yaml，状态/可达性不一致时告警
- 新增 cron `Homepage 链接校验`（小时级，547db22c83d2）
- 判定口径：HTTP 2xx 或 401/403 = running；其他 4xx/5xx/超时/连接拒绝 = not-running
- 首页仪表盘展示优先级：**服务状态 + 风险等级**；下一步动作可作为增强项

### 阶段 6：LAN 段实探

已落地：
- 本机 = 192.168.2.249，192.168.2.0/24 直连，无需 SSH 反向
- Tailscale 入口通过 MagicDNS 解析，`shin.tail8a16d3.ts.net` 已实探
- 校验脚本可同时覆盖 LAN / tailnet / localhost 三档

实机新事实（2026-06-15 核验）：
- SearXNG：Docker 容器运行中，`/healthz` 200，端口 7777 监听（已恢复）
- n8n：拉起成功，pid 3569827，端口 5678 监听，根路径 200，healthz 200（已恢复）
- LiteLLM：ChatGPT OAuth refresh_token 401，4 个 `chatgpt/gpt-*` model 临时下架，容器已恢复，liveliness/readiness 双 200
  - 备份：`/home/shin/workspace/litellm/config.yaml.bak-chatgpt-oauth-401-20260615_*`
  - 待办：重新走 ChatGPT OAuth 后取消注释

### 阶段 7：服务恢复动作（2026-06-15）

- n8n：直接 `n8n start`，工作流数据保留在 `/home/shin/.n8n/`
- SearXNG：已由 Docker 守护进程拉起，无需手工
- LiteLLM：临时下架过期 ChatGPT model，容器自愈

「待恢复」分组现状：这是 2026-06-15 当时的结果，两个 yaml 一度为空（`[]`），且核心服务状态与实机一致；截至 2026-06-17 复核，n8n 已回到 `installed-not-running`，`待恢复` 分组不应再写成全空

### 阶段 8：LiteLLM 模型全员阿里化（2026-06-15）

**问题发现**：跑 `/health` 拿全 26 model 健康快照，发现 Bailian 9 个全 401，已下架厂商 5 个余额 / 套餐到期，Gemini 8 个 429 限流，MiniMax 1 个 401。**真正健康的只有 3 个 SenseNova（11%）。**

**第一轮：已下架厂商 临时下架 + Bailian 切 Token Plan 团队版**

- 用户提供新 key：`sk-sp-D.HIYDY.vQ1L.MEQCI...Bg==`
- `BAILIAN_CODING_API_KEY` 替换为 Token Plan 团队版 key（旧 Coding Plan key 失效）
- 5 个 Bailian 可用 model（qwen3.6-plus / kimi-k2.5 / glm-5 / MiniMax-M2.5）切到 `token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1`
- 5 个 Bailian 旧 model + 5 个 已下架厂商 全部注释
- 健康率：3/26 → 7/16（11% → 44%）

**第二轮：实探 + 全部阿里模型上挂**

- Token Plan 实测能力：`/v1/models` 列出 16 个 model，实测 12 个文本 model 全部 200 OK
- 用户要求"阿里的模型都给我整上"
- 新增 8 个 Bailian Token Plan model：
  - `Bailian-qwen3.7-max` / `qwen3.7-plus` / `qwen3.6-flash`
  - `Bailian-kimi-k2.6`
  - `Bailian-glm-5.1`
  - `Bailian-deepseek-v3.2` / `v4-flash` / `v4-pro`
- 健康率：7/16 → **15/24（44% → 62.5%）**

**踩坑记录**：

- `docker compose restart` **不会重读 `env_file`**，必须 `docker rm` + `docker run`（或 `up -d`）才能拿到新 key
- Token Plan **不支持 Claude model**（Anthropic 端点 404 "model not found"）
- Token Plan **不支持 qwen3-coder-***（qwen3-coder-plus / qwen3-coder-next / qwen3.5-plus / qwen3-max / glm-4.7 全部 400）
- 阿里官方面对 LiteLLM 这种自定义代理时报 `401 Invalid API-key` 是用错 Base URL 的标志
- shell 单引号吃 `==` 的字符串要小心，用环境变量 + python 调用避免

**当前状态**：

| 类别 | 数 | 健康 | 备注 |
|------|----|------|------|
| Bailian Token Plan | 12 | 12 | 全绿，包含 qwen3.7-max/plus、qwen3.6-plus/flash、kimi-k2.5/2.6、glm-5/5.1、MiniMax-M2.5、deepseek-v3.2/v4-flash/v4-pro |
| SenseNova | 3 | 3 | sensenova-6.7-flash-lite、deepseek-v4-flash（注意和 Bailian 重复 model_name）、sensenova-u1-fast |
| MiniMax-M2.7 | 1 | 0 | 厂商鉴权失败，留着待用户处理 |
| Gemini | 8 | 0 | 429 限流，用户拍板先跳过 |
| ChatGPT（已下架） | 4 | — | OAuth 401，等重新登录 |
| 已下架厂商（已下架） | 5 | — | 余额 / 套餐到期 |
| Bailian 旧 model（已下架） | 5 | — | 不在 Token Plan 列表 / Coding Plan key 失效 |
| **合计** | 24+14=38 | **15/24=62.5%** | |

**档案库同步**：

- `docs/LiteLLM-健康快照-2026-06-15.md` 新增第三轮快照表
- `credentials/LLM-厂商配置基线.md` 修订百炼节：当前凭证类型从 Coding Plan 改为 Token Plan 团队版，列出 12 个全绿的挂载 model
- 备份：`config.yaml.bak-zai-down-bailian-tokenplan-20260615_122352`、`config.yaml.bak-bailian-all-on-20260615_123300`、`config.yaml.bak-bailian-full-20260615_123700`

**待办**：

- MiniMax-M2.7 厂商侧鉴权（与 Token Plan 无关）
- Gemini 限流恢复 / 换 key
- ChatGPT 4 个 OAuth 重新登录
- 已下架厂商 5 个续费后恢复
- 4 个 Bailian 旧 model 是否需要切回 Coding Plan（看你订阅状态）

---
## 5. 用户需要怎么配合

你只需要做最少的事。

### 你需要提供的输入

1. **新增服务名称**：比如 `immich`、`n8n`、`alist`
2. **该服务的真实入口**：URL / 端口 / 容器名 / 本机路径
3. **是否允许我核验实机状态**：能查进程、端口、容器就直接查
4. **是否允许自动写文档**：允许的话，我先核实，再直接更新
5. **是否需要接入告警/主页/备份**：如果你不说，我默认先不乱接，只补档案

### 你不用重复做的事

- 不用把同一份信息发给我三次
- 不用自己改 README、拓扑、WIKI、总览四处
- 不用手工同步状态
- 不用自己猜我该改哪些文件

---

## 6. 我这边的最简化操作流程

以后每新增一个服务，我按这个顺序执行：

1. 实机核验
2. 创建/更新服务 README
3. 补凭证记录
4. 同步 WIKI 索引
5. 同步拓扑图
6. 同步总览 README
7. 补健康检查 / 备份 / 告警 / 恢复
8. 写迭代记录

如果信息已经存在，我只做增量修改，不重写整套文档。
如果信息无法核实，我保留原文，不硬改。

---

## 7. 后续新增内容的操作方法

### 推荐方式：一条消息交代清楚

你发我一句话就够：

> 新增 xxx 服务，地址是 xxx，帮我按档案库规则接入。

我会自动做：
- 查当前仓库里是否已有对应档案
- 查是否已经部署/运行
- 查是否需要补 README / WIKI / 拓扑 / 总览
- 查是否需要补 USAGE_MANUAL
- 把能核实的内容直接更新

### 如果你想更省事

你可以只给我：
- 服务名
- 访问地址
- 是否允许我直接改文档

其余我来补。

---

## 8. 当前执行顺序建议

1. 继续补齐已有服务的 `USAGE_MANUAL`
2. 给新增服务统一接入模板
3. 逐步把告警和备份自动化
4. 再考虑 Homepage / 事件通知 / 巡检联动

---

## 9. 结论

这套整理计划的核心不是“写更多文档”，而是：

- **减少分叉**
- **减少口头规则**
- **减少重复操作**
- **把事实与文档对齐**

以后档案库只按这一套跑。