# Harness 项目合规检查表（v0.1）

> 与 Harness-工程规范.md 配套使用
> 用途：项目上线前的强制检查项 + 自动化提醒的判据

---

## 检查流程（4 步）

### Step 1：定位卡类型
- Agent Harness 卡 → 适用 Agent/工具层
- 场景 Harness 卡 → 适用业务场景层

### Step 2：逐项打勾
按 8 构件清单逐项判断 ✅ / ❌ / ⚠️（部分满足）

### Step 3：计算合规度
合规度 = 满足的构件数 / 8

### Step 4：决定是否上线
按合规度决策表判断

---

## 上线决策表

| 合规度 | 决策 | 处理 |
|---|---|---|
| **0-3/8** | 🚫 **禁止上线** | 必须补齐基础件套 |
| **4-5/8** | ⚠️ **可以小范围试点** | 上线时显式声明缺失项及风险 |
| **6/8** | ✅ **可以灰度上线** | 受控范围试运行 |
| **7-8/8** | ✅ **可以正式上线** | 标准维护流程 |

---

## Agent Harness 卡检查表

> 每个 Agent/工具（Hernes、OpenClaw、Claude Code、Codex、Cursor）填一张

```markdown
# Agent Harness 卡：<Agent 名>

## 1. 基础信息
- Agent 类型：执行型 / 编排型 / 工具型 / 编辑器型
- 主归类：AI Center L3 运行层
- 入口：CLI / API / WebUI / IDE 插件
- 默认模型：<LiteLLM 中台 / 直连厂商>
- 最近更新：YYYY-MM-DD

## 2. 8 构件检查

| # | 构件 | 状态 | 载体/位置 | 缺失原因 |
|---|---|---|---|---|
| 1 | System Prompt | ✅/❌ | — | — |
| 2 | Tools | ✅/❌ | — | — |
| 3 | Sandbox | ✅/❌ | — | — |
| 4 | Filesystem | ✅/❌ | — | — |
| 5 | Memory | ✅/❌ | — | — |
| 6 | Feedback | ✅/❌ | — | — |
| 7 | Guardrail | ✅/❌ | — | — |
| 8 | Observability | ✅/❌ | — | — |

**合规度：N/8**

## 3. 业务可承接范围
- 能跑哪类业务（编码 / 调研 / 内容 / 1v1 / 自动化）
- 不能跑哪类（为什么不能）

## 4. 已知失败模式
| 失败模式 | 触发条件 | 规避方法 |
|---|---|---|
| — | — | — |

## 5. 关联
- 父业务卡：—
- 关联 Agent 卡：—
- 关联场景卡：—
```

---

## 场景 Harness 卡检查表

> 每个业务场景填一张

```markdown
# 场景 Harness 卡：<场景名>

## 1. 场景定义
- 一句话：做什么的
- 解决什么业务问题：
- 涉及的业务数据/客户在哪：
- 父业务卡：

## 2. 8 构件检查

### ✅/❌ 1. System Prompt
- 复用哪个 Agent 的 prompt：
- 场景专属 prompt 写在哪：

### ✅/❌ 2. Tools
- 用到哪些工具：（搜索/写文件/调 API/发消息/执行命令）
- 工具白名单：
- 工具黑名单：

### ✅/❌ 3. Sandbox
- 执行环境：（Docker/VM/工作目录）
- 能否并行跑：
- 出错能否回滚：

### ✅/❌ 4. Filesystem
- 任务进度文件：（progress.txt / feature_list.json / 其他）
- 中间产物路径：
- 跨会话续跑入口：

### ✅/❌ 5. Memory
- 短期上下文策略：
- 长期记忆沉淀什么：
- 记忆检索方式：

### ✅/❌ 6. Feedback
- 完成判定标准：
- 自动验证器：
- 失败重试规则：

### ✅/❌ 7. Guardrail
- 必须人审的动作：
- 审批方式：
- 审批超时处理：

### ✅/❌ 8. Observability
- 日志路径：
- 监控指标：（成功率/时长/成本）
- 告警触发条件：

**合规度：N/8**

## 3. 失败模式预案
- 跑挂了怎么恢复：
- 数据丢了怎么找回：
- 误发了怎么撤回：

## 4. 商业化指标
- 每月能省多少时间：
- 每月能带来多少 GMV：
- 投入产出比：
- 何时下线：

## 5. 关联
- 父业务卡：
- 依赖 Agent 卡：
- 状态卡路径：
```

---

## 自动检查脚本（harness-check.sh）

```bash
#!/bin/bash
# harness-check.sh
# 扫描所有 Harness 卡，计算合规度，输出报告

AGENTS_DIR="$HOME/PersonalKnowledge/AI-Center/agents"
PROJECTS_DIR="$HOME/PersonalKnowledge/AI-Center/projects"

echo "=== Harness 合规度检查报告 ==="
echo "检查时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 检查 Agent 卡
echo "--- Agent Harness 卡 ---"
if [ -d "$AGENTS_DIR" ]; then
    for card in "$AGENTS_DIR"/*.md; do
        [ -f "$card" ] || continue
        name=$(basename "$card" .md)
        score=0
        for i in 1 2 3 4 5 6 7 8; do
            if grep -q "✅" "$card"; then
                score=$((score+1))
            fi
        done
        echo "[$score/8] $name"
    done
fi

echo ""
echo "--- 场景 Harness 卡 ---"
if [ -d "$PROJECTS_DIR" ]; then
    for card in "$PROJECTS_DIR"/*/harness-card.md; do
        [ -f "$card" ] || continue
        name=$(basename "$(dirname "$card")")
        score=0
        for i in 1 2 3 4 5 6 7 8; do
            if grep -q "✅/❌ $i\." "$card" || grep -q "✅.*$i\." "$card"; then
                score=$((score+1))
            fi
        done
        echo "[$score/8] $name"
    done
fi
```

**位置**：`~/bin/harness-check.sh`

**运行方式**：`bash ~/bin/harness-check.sh`

---

## 自动化提醒（n8n + Hermes cron）

### Cron 任务配置

```yaml
name: harness-compliance-daily
schedule: "0 9 * * *"  # 每天 9:00
prompt: |
  你是 harness 合规巡检助手。

  步骤：
  1. 跑 bash ~/bin/harness-check.sh
  2. 解析输出
  3. 对合规度 < 6 的卡，生成提醒消息
  4. 用 send_message 发微信提醒用户
  5. 把当日报告写入 ~/PersonalKnowledge/AI-Center/operations/harness-report-YYYYMMDD.md

  提醒模板：
  「⚠️ Harness 合规提醒
  发现 X 个项目合规度不足 6/8：
  - 项目 A：4/8（缺 Feedback、Guardrail、Observability）
  - 项目 B：5/8（缺 Feedback、Guardrail）
  建议今天补完。」
```

---

## 文档版本

- v0.1（2026-06-27）：初版