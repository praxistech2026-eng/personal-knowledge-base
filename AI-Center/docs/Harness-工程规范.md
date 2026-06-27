# Harness 工程规范（v0.1）

> 来源：小甜心 2026-06-27 启动
> 定位：**横向治理协议，不单独成层**
> 目的：让 AI Center 的每个 Agent / 每个项目在搭建时有 8 件套检查项可对照，避免"跑起来后发现缺东西"

---

## 0. Harness 是什么（一句话）

**Agent = Model + Harness**。Model 是大脑（概率性思考），Harness 是围绕大脑的身体+工具+记忆+护栏+反馈，把"提示词-回答"的一次性交互变成**可重复、可验证、可规模化**的工作流。

---

## 1. Harness 8 构件（核心）

| # | 构件 | 解决的问题 | 不做的后果 | 你的 AI Center 对应载体 |
|---|---|---|---|---|
| 1 | **System Prompt** | 每次运行都吃的站立指令 | 行为漂移、每次表现不一样 | Hermes SOUL.md / 各 Agent 的 AGENTS.md |
| 2 | **Tools / Function Calling** | 让模型能动手 | 模型只能"说"不能"做" | hermes-tools / OpenClaw tools / MCP servers |
| 3 | **Sandbox / 执行环境** | 隔离、可重置、可并行 | 一次失误污染整条链路 | Docker / PVE 虚机 / 工作目录 |
| 4 | **Filesystem / 持久存储** | 任务进度、plans、memory 落盘 | 跨会话失忆、长任务中断 | 项目仓库 / Obsidian / AI-Center 文档 |
| 5 | **Memory & Context 管理** | 短期上下文压缩 + 长期记忆检索 | 长任务崩、context anxiety | Hindsight / MEMORY.md / memory/日期.md |
| 6 | **Feedback Loop / 验证** | Reason→Act→Observe 循环 + 自动验证 | 模型自信地说"做完了"实际是屎 | n8n / 测试脚本 / 人审环节 |
| 7 | **Guardrails / 人审** | 删文件/发消息/下单前必须人批 | 一次失控不可逆 | 微信卡片 / 飞书审批 / 命令确认 |
| 8 | **Observability / 日志** | 每次跑过什么、为什么、能否回放 | 出问题没人能复盘 | Homepage 仪表盘 / 日志归档 / 成本面板 |

### 1.1 加件原则（Anthropic 实测验证）

**加一个就测一次，没用就砍**——Anthropic 在 OSWorld 实测发现：加 Verifier 模块反而让表现 -8.4 分。

每加一个 Harness 构件前，问 3 个问题：
1. 这个构件解决了哪个**真实失败模式**？（不是"以防万一"）
2. 怎么测它**有效**？（不是"看起来有用"）
3. 如果去掉它，**会出什么具体问题**？

3 个问题答不上来的构件不要加。

### 1.2 自然语言 Harness 优于代码 Harness（Tsinghua 论文结论）

- 不要写复杂的 Python harness 代码
- 优先用 `AGENTS.md` / `Skills` / 自然语言规范来定义 harness
- 这是**对你（不写代码）最有利的设计原则**

---

## 2. Harness 在 AI Center 6 层里的挂载位置

```
┌─────────────────────────────────────────┐
│ L6 项目状态层                            │  ← 每张项目卡新增 "harness 合规度" 字段
├─────────────────────────────────────────┤
│ L5 项目层                               │  ← 每个项目是一张 Harness 项目卡
├─────────────────────────────────────────┤
│ L4 能力层                               │  ← 每个能力被多少 harness 场景调用
├─────────────────────────────────────────┤
│ L3 运行层                               │  ← 每个 Agent 是 harness 8 构件的承载者
├─────────────────────────────────────────┤
│ L2 连通层                               │  ← 通道层决定 harness 跨设备可达性
├─────────────────────────────────────────┤
│ L1 物理层                               │  ← 物理层决定 harness 并发能力上限
└─────────────────────────────────────────┘

横切：Harness 8 构件（在每一层都有它的检查项）
```

**关键**：6 层结构**不动**，harness 作为治理维度嵌进去。

---

## 3. Harness 卡分类

### 3.1 Agent Harness 卡（每个 Agent/工具一张）

适用于：Hermes / OpenClaw / Claude Code / Codex / Cursor / 未来新 Agent

**位置**：`~/PersonalKnowledge/AI-Center/agents/<agent-name>-harness-card.md`

**字段**：
1. 基础信息（Agent 类型、主归类、入口、默认模型）
2. 8 构件填表（✅/❌ + 载体 + 缺失原因）
3. 业务可承接范围（能跑什么、不能跑什么）
4. 已知失败模式（历史踩过的坑）
5. 最近更新时间

### 3.2 项目/场景 Harness 卡（每个业务场景一张）

适用于：私域内容生产、1v1 成交辅助、调研支持、订单录入……

**位置**：`~/PersonalKnowledge/AI-Center/projects/<project-name>/harness-card.md`

**字段**：
1. 场景定义（一句话 + 解决什么业务问题）
2. 8 构件逐项检查（每项 ✅/❌ + 详细说明）
3. 失败模式预案（跑挂了怎么恢复、数据丢了怎么找回、误发了怎么撤回）
4. 商业化指标（每月能省多少时间 / 带来多少 GMV / 投入产出比）
5. 关联（父业务卡 + 依赖 Agent 卡 + 状态卡路径）

---

## 4. Harness 合规度评分

每个 Harness 卡计算合规度：**N/8**（N 为打勾的构件数）。

| 合规度 | 含义 | 处理 |
|---|---|---|
| **0-3/8** | 严重不完整，**不能上线** | 必须补齐基础件套 |
| **4-6/8** | 基本可用，可以小范围试点 | 上线时显式声明缺失项及风险 |
| **7-8/8** | 完整，可以正式上线 | 标准维护 |

**业务上线红线**：合规度 < 4/8 不允许进入生产环境。

---

## 5. 自动提醒机制（两层）

### 5.1 轻量级：harness-check.sh

每周/每次新建项目时跑一次，扫描所有 Harness 卡，输出合规度报告。

**位置**：`~/bin/harness-check.sh`

### 5.2 重量级：Hermes cron 每日合规巡检

每天定时扫一遍所有项目卡：
- 合规度 < 6 的项目 → 微信发提醒
- 合规度 = 8 的项目 → 仅记日志
- 新建项目卡但未跑过 harness-check → 提醒补跑

**实现位置**：n8n + Hermes cron job

---

## 6. Harness 与未来扩展层的关系

### 6.1 与 L7 合规层的关系

Harness 的 Guardrail 构件 + Observability 构件 = 合规层的最小子集
当合规层启动时，Harness 的对应构件升级为"合规强制项"

### 6.2 与 L8 财务层的关系

Harness 的 Observability 构件需要扩展"成本归集"维度
当财务层启动时，Harness 的 Observability 构件升级为"成本核算"

**当前不实施**，仅作为扩展点登记。

---

## 7. 文档清单

| 文档 | 路径 | 状态 |
|---|---|---|
| Harness-工程规范.md（本文件） | ~/PersonalKnowledge/AI-Center/docs/ | ✅ v0.1 |
| Harness-8构件清单.md | ~/PersonalKnowledge/AI-Center/docs/ | 📝 待写 |
| Harness-项目合规检查表.md | ~/PersonalKnowledge/AI-Center/docs/ | 📝 待写 |
| Agent Harness Card 模板 | ~/PersonalKnowledge/AI-Center/agents/_template.md | 📝 待写 |
| 场景 Harness Card 模板 | ~/PersonalKnowledge/AI-Center/projects/_template/harness-card.md | 📝 待写 |
| harness-check.sh | ~/bin/harness-check.sh | 📝 待写 |

---

## 8. 下一步

W0 落地清单（这周）：
1. Harness-8构件清单.md
2. Harness-项目合规检查表.md
3. Agent Harness Card 模板 + Hermes 第一张样板卡
4. harness-check.sh v0.1

W1：
5. 选 1 个高负载业务场景（推荐"100 群新客户涌入自动分流"），填场景 Harness 卡
6. 用真实业务压力打 6 层架构 + Harness 8 构件