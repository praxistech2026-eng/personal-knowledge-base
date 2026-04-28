# HermesKnowledge 自动化系统

> 版本：v0.1.0
> 目录：`.system/`

## 架构

```
HermesKnowledge/
├── .system/              ← 自动化系统（版本受 SemVer 管理）
│   ├── scripts/
│   │   ├── hermes-push      手动立即同步
│   │   ├── hermes-release   发布新版本
│   │   └── hermes-watch     实时文件监控
│   └── CHANGELOG.md
│
├── Knowledge/             ← 知识库（实时同步 GitHub）
├── AgentSessions/        ← 会话存档（实时同步 GitHub）
└── ...
```

## 双层同步机制

| 层级 | 同步方式 | 版本控制 | 说明 |
|------|---------|---------|------|
| **数据层** | 实时（变更即 push） | 无 tag | 笔记/会话随时同步 |
| **系统层** | 手动发布 | SemVer tag | 脚本/规则变更管理 |

## 核心命令

### hermes-push（手动同步）

```bash
~/.hermes/HermesKnowledge/.system/scripts/hermes-push
```

立即同步所有变更到 GitHub。

### hermes-watch（实时监控）

```bash
# 需要安装 inotify-tools
sudo apt install inotify-tools

# 启动监控（后台运行）
~/.hermes/HermesKnowledge/.system/scripts/hermes-watch

# 停止监控
kill "$(cat ~/.hermes/HermesKnowledge/.system/hermes-watch.pid)"
```

文件变更后 2 秒自动触发同步。

### hermes-release（发布）

```bash
~/.hermes/HermesKnowledge/.system/scripts/hermes-release [major|minor|patch]
```

| 参数 | 效果 |
|------|------|
| `patch` | 修复/小优化（默认） |
| `minor` | 新功能（向后兼容） |
| `major` | 破坏性变更 |

## SemVer 版本规范

```
v{MAJOR}.{MINOR}.{PATCH}
v0.1.0
```

- **MAJOR**：不兼容的 API 变更
- **MINOR**：新增功能（向后兼容）
- **PATCH**：修复/小优化

## 当前版本

```bash
git describe --tags --abbrev=0
# v0.1.0
```

## CHANGELOG

所有版本变更记录在 [CHANGELOG.md](./CHANGELOG.md)。
