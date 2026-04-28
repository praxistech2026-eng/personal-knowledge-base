# HermesKnowledge 版本管理方案

## 一、三层版本架构

```
main (稳定分支)
  └── 始终是可发布的稳定状态
  └── 只有通过正式合并才更新
  └── 重大更新后打 tag

dev (开发分支)
  └── 日常提交在这里
  └── 积累到一定阶段合并到 main
  └── 合并时生成 CHANGELOG 条目

AgentSessions/ (独立追踪)
  └── 不影响 main 的版本稳定性
  └── 单独配置 .gitignore
```

## 二、Tag 版本规范

格式：`v{YY}.{MM}.{序列号}`

示例：
```
v26.04.01  ← 2026年4月第1个正式版
v26.04.02  ← 2026年4月第2个正式版
v26.05.01  ← 2026年5月第1个正式版
```

## 三、Archive 策略

| 触发条件 | 归档内容 |
|---------|---------|
| `ha` 合并时 | 被覆盖的旧版 → Archive/ |
| 每月底 | 当月所有变更快照 → Archive/monthly/ |
| 重大版本前 | 完整 vault 快照 → Archive/releases/ |
| 手动触发 | `archive-snapshots.sh` 脚本 |

## 四、发布流程

```
日常 → dev 分支
    ↓
准备发布 → 从 dev 创建 release 分支
    ↓
审核 CHANGELOG → 确认变更内容
    ↓
合并到 main → 打 tag v26.04.02
    ↓
发布完成
```

## 五、CHANGELOG 结构

```markdown
# Changelog

## v26.04.02 (2026-04-28)

### 新增
- 会话自动归档系统 (AgentSessions/)
- 每小时 cronjob 自动归档

### 知识更新
- Transformer 知识卡片更新

### 修复
- hn/ha 命令 PATH 问题
```

---

*最后更新：2026-04-28*
