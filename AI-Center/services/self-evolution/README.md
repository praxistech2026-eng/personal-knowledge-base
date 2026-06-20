# 自我进化

> 使用遗传-帕累托算法（GEPA）自动优化 Skills 和系统提示词。

## 官方资源

| 资源 | 链接 |
|------|------|
| DSPy GitHub | https://github.com/stanfordnlp/dspy |
| GEPA 论文 | ICLR 2026 Oral |

## 组件

| 组件 | 版本 | 说明 |
|------|------|------|
| DSPy | 2.6.27 | 提示词编程框架 |
| GEPA | 0.1.1 | Genetic-Pareto Evolution |
| hermes-agent-self-evolution | 0.1.0 | 独立仓库 `~/self-evolution/` |

## 环境

| 路径 | 说明 |
|------|------|
| `~/self-evolution/` | NousResearch 克隆仓库 |
| `~/.hermes/self-evolution-venv/` | 独立 venv（dspy 2.6.27 + gepa 0.1.1） |
| `~/.hermes/hermes-agent/` | Hermes Agent 代码库（被优化目标） |
| `~/self-evolution/run-evolve.sh` | Wrapper 脚本 |

## 使用方式

```bash
# Dry-run 验证
~/self-evolution/run-evolve.sh github-code-review --dry-run

# 合成数据模式（推荐首次，$2-10/次）
~/self-evolution/run-evolve.sh <skill-name> 10 synthetic
```

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | `~/self-evolution/run-evolve.sh`、独立 venv、相关 tests | 不是常驻进程，按工具链检查 |
| 检查命令 | `~/self-evolution/run-evolve.sh github-code-review --dry-run`；`pytest tests/ -q` | dry-run + 测试 |
| 判据 | dry-run 退出码 0，测试通过，venv 可用 | 工具可用 |
| 频率 | 每次改 skill / prompt / venv 后 | 变更即查 |
| 失败动作 | 先修脚本或环境，再重新 dry-run | 先修环境 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `~/self-evolution/` 仓库、说明文档、脚本 | 核心代码与配置 |
| 备份方式 | Git 版本化；venv 可重建 | 不做二进制备份 |
| 频率 | 每次改动后提交 | 版本留痕 |
| 保留策略 | Git 历史保留 | 默认保留足够 |
| 恢复命令 | 重新拉仓库 + 重建 venv + 再跑 dry-run | 可重建即恢复 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | dry-run 失败、pytest 失败、依赖缺失 | 任一即异常 |
| 通知渠道 | 当前无自动告警 | 先人工发现 |
| 兜底动作 | 停止应用新优化，先修环境 | 不把坏配置继续推 |
| 升级路径 | 人工 review 后再继续进化 | 审核后再动 |

### 恢复 / 回滚

- 直接回退 Git 提交
- 重新安装依赖后再做 dry-run 验证

## 约束门控

- Skill ≤15KB，工具描述 ≤500 字符
- `pytest tests/ -q` 100% 通过
- 语义一致性验证
- 人工 PR 评审（非直接提交）

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署三层闭环进化系统 |
