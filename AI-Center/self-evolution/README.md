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

## 约束门控

- Skill ≤15KB，工具描述 ≤500 字符
- `pytest tests/ -q` 100% 通过
- 语义一致性验证
- 人工 PR 评审（非直接提交）

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署三层闭环进化系统 |
