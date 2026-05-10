# AI Center

> 部署在家庭服务器上的 AI 智能体系统，包含 Agent、记忆、搜索、语音等全套能力。

---

## 系统架构

```
┌─────────────────────────────────────────────────────────────┐
│                  远程访问: Tailscale VPN                    │
│     shin (Linux) ←→ wangxindemacbook-pro (Mac)           │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                     AI Center (localhost)                    │
│                                                             │
│  hermes-gateway ──→ openclaw-gateway (同一进程)            │
│       │                     │                               │
│       └──────┬──────────────┘                               │
│              ↓                                              │
│  hermes-webui (8787) ← 浏览器访问                          │
│              ↓                                              │
│  Hindsight PostgreSQL (8888/5432) ← 向量记忆               │
│              ↓                                              │
│  SearXNG Docker (7777) ← 搜索聚合                          │
└─────────────────────────────────────────────────────────────┘

外部平台: 飞书 / 微信

AI Provider: MiniMax-M2.7 (主) / DeepSeek-V3.2 (备)
```

---

## 服务目录

| 服务 | 功能 | 端口 |
|------|------|------|
| [hermes](../services/hermes/README.md) | 主 Agent 框架 | 18789/18791/3334 |
| [openclaw](../platforms/openclaw/README.md) | Agent 执行层（与 Hermes 共进程） | 18789 |
| [hindsight](../services/hindsight/README.md) | 长期记忆与向量检索 | 8888 |
| [hermes-webui](../services/hermes/README.md#hermes-webui) | Web 管理界面 | 8787 |
| [searxng](../services/searxng/README.md) | 隐私搜索聚合引擎 | 7777 |
| [feishu](../platforms/feishu/README.md) | 飞书消息集成 | — |
| [wechat](../platforms/wechat/README.md) | 微信消息集成 | — |
| [minimax](../platforms/minimax/README.md) | 主模型提供商 | — |
| [volcengine](../platforms/volcengine/README.md) | 备选模型（DeepSeek/Doubao） | — |
| [whisper](../tools/whisper/README.md) | 本地语音识别 | — |
| [edge-tts](../tools/edge-tts/README.md) | 本地语音合成 | — |
| [sessions-backup](../services/sessions-backup/README.md) | 会话存档备份（热备/冷备/Hindsight） | — |
| [fal-ai](../tools/fal-ai/README.md) | AI 图像生成 | — |
| [search-tools](../tools/search-tools/README.md) | 搜索工具矩阵 | — |
| [self-evolution](../services/self-evolution/README.md) | 自我进化优化 | — |
| [oracle-cloud](../infrastructure/oracle-cloud/README.md) | Oracle Cloud VPS | — |
| [tailscale](../infrastructure/tailscale/README.md) | VPN 远程访问 | — |
| [skills-system](../skills-system/README.md) | 技能系统 | — |

---

## 运维

### 常用命令

```bash
# 查看 Hermes Gateway 状态
systemctl --user status hermes-gateway

# 查看 Hindsight 状态
curl -s http://127.0.0.1:8888/health

# 查看 SearXNG
curl -s http://127.0.0.1:7777 | head -5

# 查看 cron 任务
crontab -l

# 手动运行 session 归档
python3 ~/bin/session_archive.py

# 手动运行知识库 push
~/PersonalKnowledge/.system/scripts/hermes-push-auto
```

### 日志位置

| 服务 | 日志路径 |
|------|---------|
| Hermes Gateway | `~/.hermes/logs/gateway.log` |
| Session 归档 | `~/logs/session_archive.log` |
| Evolution | `~/.hermes/evolution/logs/` |
| Hindsight API | systemd journal |

---

## 容灾

```
PersonalKnowledge (GitHub: praxistech2026-eng/personal-knowledge-base)
~/.hermes-archive/ (GitHub: praxistech2026-eng/sessions-backup)
Hindsight PostgreSQL (实时向量检索)
```
