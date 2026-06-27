# Harness 8 构件清单（v0.1）

> 与 Harness-工程规范.md 配套使用
> 用途：每张 Agent Harness 卡 / 场景 Harness 卡都对照本清单逐项打勾

---

## 构件 1：System Prompt（系统提示词）

### 是什么
每次 Agent 启动都吃的"站立指令"——定义行为边界、风格、约束。

### 关键问题
- [ ] 这个 Agent 有没有 `AGENTS.md` / `SOUL.md` / 系统提示词文件？
- [ ] 文件位置在哪？每次启动会自动加载吗？
- [ ] 是否包含：身份定义 / 行为约束 / 工具边界 / 输出风格 / 失败处理？

### 你的 AI Center 对应载体
- **Hermes**：`~/.hermes/SOUL.md` + 各 skill 的 `SKILL.md`
- **OpenClaw**：OpenClaw 自身 system prompt
- **Claude Code**：每个项目的 `CLAUDE.md`（如已有）
- **Codex**：OpenAI Codex CLI 的 prompt
- **Cursor**：项目级 `.cursorrules`

### 缺失风险
行为漂移——同样的输入，不同会话表现不同

### 最小落地成本
写一个 50-100 行的 `AGENTS.md` 即可

---

## 构件 2：Tools / Function Calling（工具调用）

### 是什么
让模型能"动手"——搜索、写文件、调 API、发消息、执行命令。

### 关键问题
- [ ] 这个 Agent 能调用哪些工具？
- [ ] 工具白名单/黑名单是什么？
- [ ] 工具调用失败时怎么处理（重试 / 降级 / 报错）？
- [ ] 是否支持 MCP（Model Context Protocol）？

### 你的 AI Center 对应载体
- **Hermes**：`hermes-tools` 全套
- **OpenClaw**：MCP servers + 网关层工具
- **Claude Code**：内置工具 + 项目级 `.claude/settings.json`
- **Codex**：OpenAI Codex 内置工具

### 缺失风险
模型只能说不能做——只能生成方案文本，无法执行

### 最小落地成本
直接复用现有工具集（多数 Agent 已具备）

---

## 构件 3：Sandbox / 执行环境（沙箱）

### 是什么
隔离的执行空间——Agent 跑命令、写文件不影响宿主系统。

### 关键问题
- [ ] 这个 Agent 的执行环境是什么？（Docker / VM / 工作目录）
- [ ] 能否并行跑多个实例不互相影响？
- [ ] 出错能否快速重置？
- [ ] 文件系统是否隔离？

### 你的 AI Center 对应载体
- **Hermes**：Docker 容器化部署
- **OpenClaw**：MCP server 隔离
- **Claude Code**：项目工作目录隔离
- **Codex**：Codex CLI 的沙箱（OpenAI 实现）

### 缺失风险
一次失误污染整条链路 / 无法并行扩展

### 最小落地成本
为每个 Agent 划定独立工作目录即可（不必都用 Docker）

---

## 构件 4：Filesystem / 持久存储（文件系统）

### 是什么
任务进度、plans、memory 落盘——跨会话不丢。

### 关键问题
- [ ] 任务进度写在哪？（Anthropic 范式：`progress.txt` + `feature_list.json`）
- [ ] 中间产物存哪？
- [ ] 跨会话怎么续跑？（"上次的进度从哪读"）
- [ ] 文件结构是否标准化？

### 你的 AI Center 对应载体
- **Hermes**：`~/.hermes/memory/` + `MEMORY.md` + Hindsight
- **OpenClaw**：OpenClaw 自有 storage
- **Claude Code**：项目仓库的 `docs/` + exec-plans
- **Codex**：Codex 的 session 存储

### 缺失风险
跨会话失忆 / 长任务中断后无法续跑

### 最小落地成本
定义一个固定目录结构（如 `~/projects/<project>/{progress,plans,memory}/`）

---

## 构件 5：Memory & Context 管理（记忆与上下文）

### 是什么
短期上下文（当前会话）+ 长期记忆（跨会话知识）的管理。

### 关键问题
- [ ] 短期上下文怎么压缩？（compaction / 摘要 / 截断）
- [ ] 长期记忆存哪？（Hindsight / 文件 / 数据库）
- [ ] 记忆检索机制是什么？（semantic search / keyword / 时间序列）
- [ ] 记忆隔离：不同 Agent / 不同任务的记忆是否互相污染？

### 你的 AI Center 对应载体
- **全 Agent 共享**：Hindsight（bank=Hermes）
- **Hermes 专属**：`MEMORY.md` + `memory/日期.md` 三层结构
- **跨 Agent**：通过 Hindsight 共享语义记忆

### 缺失风险
长任务崩溃（context anxiety） / 多个 Agent 记忆互相污染

### 最小落地成本
启用 Hindsight 即可（已部署）

---

## 构件 6：Feedback Loop / 验证（反馈循环）

### 是什么
"Reason→Act→Observe"循环 + 自动验证任务是否完成。

### 关键问题
- [ ] 完成判定标准是什么？（成功 / 失败的明确判定）
- [ ] 自动验证器是什么？（n8n 节点 / 测试脚本 / AI judge）
- [ ] 失败后怎么重试？（重试几次？降级方案？）
- [ ] 是否有"假报完成"的防护？（Anthropic 实测这是最大问题）

### 你的 AI Center 对应载体
- **n8n**：自动化验证流程
- **Git**：每次跑完自动 commit，失败可回滚
- **测试脚本**：每个项目的 verify 脚本

### 缺失风险
模型自信地说"做完了"，实际是屎——这是 Anothropic 反复强调的最大失败模式

### 最小落地成本
每个项目加一个 `verify.sh` 脚本 / 验证 checklist

---

## 构件 7：Guardrails / 人审（护栏）

### 是什么
危险动作前必须人审——删文件、发客户消息、下单、调外部 API。

### 关键问题
- [ ] 哪些动作必须人审？（白名单）
- [ ] 哪些动作禁止？（黑名单）
- [ ] 审批方式是什么？（微信卡片 / 飞书审批 / 命令确认）
- [ ] 审批超时怎么办？

### 你的 AI Center 对应载体
- **微信卡片通知**：现有 Hermes 通道
- **飞书审批**（未来）：飞书 P0 接入后会用上
- **命令确认**：Hermes 的危险操作确认

### 缺失风险
一次失控不可逆——比如发错客户消息、删错文件

### 最小落地成本
写一个 `dangerous-actions.md` 黑名单

---

## 构件 8：Observability / 日志（可观测性）

### 是什么
每次跑过什么、为什么这么跑、能不能回放——出问题能复盘。

### 关键问题
- [ ] 每次跑过的日志存哪？（统一路径？）
- [ ] 关键指标：成功率 / 时长 / 成本 / Token 用量
- [ ] 告警触发条件是什么？（连续失败 / 超成本 / 超时）
- [ ] 日志归档周期？（每日 / 每周 / 每月）
- [ ] 能否回放？（从日志重建执行过程）

### 你的 AI Center 对应载体
- **Homepage 仪表盘**：现有
- **Hermes 日志**：`~/.hermes/logs/` 或 Hindsight
- **LiteLLM 日志**：模型调用记录
- **n8n 执行历史**：自动化流程日志

### 缺失风险
出问题没人能复盘 / 不知道 AI 在干嘛

### 最小落地成本
统一日志路径 + Homepage 加一个 AI 面板

---

## 8 构件自检矩阵（给 Agent / 场景卡用）

每张 Harness 卡都必须用这个矩阵自检：

| # | 构件 | 是否满足 | 载体/位置 | 缺失原因 | 计划补齐时间 |
|---|---|---|---|---|---|
| 1 | System Prompt | ✅/❌ | — | — | — |
| 2 | Tools | ✅/❌ | — | — | — |
| 3 | Sandbox | ✅/❌ | — | — | — |
| 4 | Filesystem | ✅/❌ | — | — | — |
| 5 | Memory | ✅/❌ | — | — | — |
| 6 | Feedback | ✅/❌ | — | — | — |
| 7 | Guardrail | ✅/❌ | — | — | — |
| 8 | Observability | ✅/❌ | — | — | — |

**合规度** = N/8

---

## 8 构件的依赖关系（避免重复实现）

```
System Prompt
   ↓ 指令 Agent 用什么工具
Tools
   ↓ 工具在哪里执行
Sandbox
   ↓ 任务进度落盘
Filesystem
   ↓ 跨会话记忆
Memory
   ↓ 验证任务完成
Feedback
   ↓ 危险动作拦截
Guardrail
   ↓ 所有动作的日志
Observability
```

**关键洞察**：
- System Prompt 是源头——决定了 Agent 能做什么
- Observability 是终点——决定了能不能复盘
- 中间件套都是层层递进的依赖关系

**实现时按这个顺序**：1→2→3→4→5→6→7→8

---

## 文档版本

- v0.1（2026-06-27）：初版，基于 Databricks / Anthropic / OpenAI / Martin Fowler 四家共识