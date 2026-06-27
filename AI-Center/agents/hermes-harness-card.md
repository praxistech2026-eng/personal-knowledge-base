# Agent Harness 卡：Hermes

> 适用对象：Hermes（你的 AI Agent 主入口）
> 主归类：AI Center L3 运行层
> 最近更新：2026-06-27

## 1. 基础信息
- Agent 类型：编排型 + 执行型
- 主归类：AI Center L3 运行层
- 入口：CLI / WebUI（127.0.0.1:8787）
- 默认模型：LiteLLM 中台 → MiniMax-M3 / MiniMax-M2.7
- 最近更新：2026-06-27

## 2. 8 构件检查

| # | 构件 | 状态 | 载体/位置 | 缺失原因 |
|---|---|---|---|---|
| 1 | System Prompt | ✅ | ~/.hermes/SOUL.md + 各 skill 的 SKILL.md | — |
| 2 | Tools | ✅ | hermes-tools 全套（terminal/file/web/browse/cronjob 等） | — |
| 3 | Sandbox | ⚠️ | Docker 容器化部署，但**缺标准 sandbox 模板** | 暂用 Docker 默认隔离，未定制 |
| 4 | Filesystem | ✅ | ~/.hermes/memory/ + MEMORY.md + Hindsight | — |
| 5 | Memory | ✅ | Hindsight（bank=Hermes）+ MEMORY.md 三层 | — |
| 6 | Feedback | ❌ | — | 没装自动验证器；任务完成靠人工判断 |
| 7 | Guardrail | ⚠️ | 微信告警 + 命令确认；**缺动作白名单** | 危险动作黑名单未系统化 |
| 8 | Observability | ⚠️ | Homepage 仪表盘 + ~/.hermes/logs/；**缺 AI 调用成本面板** | LiteLLM 调用记录未单独面板 |

**合规度：3.5/8（3 完整 + 2 部分）**

## 3. 业务可承接范围

**能跑**：
- 代码 review / 重构（用 hermes-tools 终端能力）
- 调研任务（web_search + web_extract）
- 文档撰写与归档（write_file + Obsidian 集成）
- 多 Agent 编排（delegate_task）
- 长任务自动化（cronjob）

**不能跑/不建议**：
- 高并发实时聊天（Hermes 单实例性能有限）
- 直接对接客户 1v1（缺微信通道稳定接入）
- 实时多模态（Hermes 主要走文本 + 基础 vision）

## 4. 已知失败模式

| 失败模式 | 触发条件 | 规避方法 |
|---|---|---|
| 跨会话失忆 | 长任务跨多 session | 用 Hindsight recall + MEMORY.md 显式记录 |
| Context anxiety | 长对话超过 50 轮 | 主动让模型做 compaction / context reset |
| 误删文件 | 缺少危险操作确认 | 重要文件操作前用 patch / 备份 |
| iLink rate limit | 微信高频发送 | 错峰发送；用飞书作备用通道 |
| Token 成本失控 | 未设置 token 上限 | LiteLLM 设置 rpm/tpm；Observability 面板待补 |

## 5. 关联

- **父业务卡**：IT 治理业务
- **关联 Agent 卡**：OpenClaw / Claude Code / Codex / Cursor
- **关联场景卡**：（待业务场景上线后补）

## 6. 下一步补强计划

| 缺失件套 | 计划 | 优先级 |
|---|---|---|
| Feedback | 给 Hermes 加 verify 任务脚本（每次关键操作后自动校验） | P1 |
| Guardrail | 起草 `dangerous-actions.md` 黑名单 | P0 |
| Observability | Homepage 加 AI 调用日志面板（成本/成功率/响应时长） | P1 |
| Sandbox | 为 Hermes 多实例部署准备 Dockerfile 模板 | P2 |