# HermesKnowledge 自动化系统 SOP

> 版本：v0.1.1
> 目录：`.system/`

---

## 一、系统架构

```
HermesKnowledge/
├── Knowledge/               ← 知识卡片（实时同步）
├── AgentSessions/           ← Agent 会话归档（实时同步）
├── Inbox/                   ← 临时收集
├── .system/                 ← 自动化系统（SemVer 版本控制）
│   ├── scripts/
│   │   ├── hermes-push         手动同步
│   │   ├── hermes-push-auto    自动同步（cron 调用）
│   │   ├── hermes-release      版本发布
│   │   └── hermes-poll         安装自动同步
│   ├── CHANGELOG.md
│   └── README.md
└── .git/                    ← GitHub 实时同步
```

---

## 二、数据层同步 SOP（笔记 / 会话）

### 2.1 自动同步（无需操作）

- **触发**：系统每分钟自动检测文件变更
- **原理**：`hermes-push-auto` 每分钟运行，发现变更即 `git add → commit → push`
- **静默模式**：无变更时不产生任何 git 噪音
- **状态**：已在 crontab 中配置

```
$ crontab -l | grep push-auto
* * * * * $HOME/HermesKnowledge/.system/scripts/hermes-push-auto
```

### 2.2 手动同步（立即推送）

```bash
# 立即同步，带时间戳提交
hermes-push

# 带自定义消息
hermes-push "更新 Transformer 笔记"
```

### 2.3 Mac 端同步

- Obsidian Git 插件自动拉取（已配置）
- 无需额外操作

---

## 三、系统层版本控制 SOP（.system/ 脚本）

### 3.1 当前版本

```bash
git describe --tags --abbrev=0
# v0.1.1
```

### 3.2 发布新版本

```bash
# patch（默认）：修复、小优化
hermes-release patch

# minor：新功能（向后兼容）
hermes-release minor

# major：破坏性变更
hermes-release major
```

发布流程：
1. 自动 bump 版本号
2. 更新 CHANGELOG.md
3. 创建 git tag
4. 推送到 GitHub

### 3.3 SemVer 规范

| 层级 | 场景 | 示例 |
|------|------|------|
| **MAJOR** | 不兼容的 API / 工作流变更 | 推翻代 push 机制 |
| **MINOR** | 新增功能（向后兼容） | 新增 hermes-poll |
| **PATCH** | 修复 / 小优化 | 修复静默模式 bug |

---

## 四、版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| v0.1.0 | 2026-04-28 | 初始自动化系统（hermes-push, hermes-watch, hermes-release） |
| v0.1.1 | 2026-04-28 | 轮询同步（hermes-push-auto, hermes-poll），切换为每分钟静默同步 |

完整变更记录见 [CHANGELOG.md](./CHANGELOG.md)。

---

## 五、目录结构约定

### 数据层（实时同步，无版本 tag）
```
Knowledge/           ← 知识卡片（hn/ha 管理）
AgentSessions/       ← Agent 会话归档
Inbox/               ← 临时输入
```

### 系统层（SemVer 版本控制）
```
.system/scripts/     ← 自动化脚本
.system/CHANGELOG.md ← 版本变更日志
```

**重要**：`.system/` 目录属于系统层，修改后需通过 `hermes-release` 发布新版本，不能随日常笔记同步随意改动。
