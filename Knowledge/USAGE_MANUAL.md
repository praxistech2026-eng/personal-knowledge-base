# PersonalKnowledge OS 使用手册

> 更新时间：2026-05-10
> 系统版本：v1.2

---

## 一、系统定位

个人知识沉淀系统 + AI Center 管理系统。

两个核心职能：
1. **Knowledge/** — 个人沉淀知识，来源包括输入素材、AI 整理、阅读笔记
2. **AI-Center/** — AI Center 完整 WIKI，每个服务独立文档

---

## 二、目录结构

```
PersonalKnowledge/
├── Knowledge/              ← 个人沉淀知识
│   ├── AI/               ← AI 技术知识
│   ├── Business/         ← 商业/创业
│   ├── Personal/         ← 个人
│   ├── Misc/             ← 杂项
│   ├── Inbox/            ← 临时输入（待整理）
│   ├── MergeQueue/       ← 合并候选
│   ├── Archive/          ← 历史备份（只增不减）
│   └── Review/           ← 待回顾
│
└── AI-Center/              ← AI Center WIKI（与 Knowledge 并级）
    ├── docs/
    │   ├── README.md            ← 总览 + 入口
    │   ├── AI-Center-拓扑图.md  ← 系统拓扑
    │   ├── AI-Center-Agent-Team-Runtime-设计说明.md
    │   └── WIKI-索引.md        ← 📍 快速索引（点击跳转）
    ├── services/                ← 常驻进程
    │   ├── hermes/             ← 主 Agent 框架
    │   ├── hindsight/          ← 长期记忆（PostgreSQL）
    │   ├── searxng/           ← 搜索聚合引擎
    │   ├── self-evolution/    ← 自我进化
    │   └── sessions-backup/   ← 会话存档备份
    ├── tools/                  ← 按需调用
    │   ├── whisper/            ← 语音识别
    │   ├── edge-tts/          ← 语音合成
    │   ├── fal-ai/            ← 图像生成
    │   └── search-tools/      ← 搜索工具矩阵
    ├── platforms/              ← 外部集成
    │   ├── feishu/            ← 飞书
    │   ├── wechat/           ← 微信
    │   ├── minimax/          ← 主模型
    │   ├── volcengine/       ← 备选模型
    │   └── openclaw/         ← 执行层 Agent
    ├── infrastructure/        ← 基础设施
    │   ├── tailscale/        ← VPN
    │   └── oracle-cloud/     ← Oracle VPS
    ├── credentials/           ← 敏感凭证
    │   └── 系统凭证备忘录.md
    ├── config/               ← 配置文件
    │   └── 花云+Mitce+Webshare+Oracle场景优化版.yaml
    └── skills-system/        ← 技能系统（76 个已安装）
```

### WIKI 快速索引

入口：`AI-Center/docs/WIKI-索引.md`

点击目录名跳转，按 services / tools / platforms / infrastructure / docs / credentials / config 七层分类，覆盖所有服务。详见 [WIKI-索引](./AI-Center/docs/WIKI-索引.md)。

---

## 三、知识沉淀工作流

### 输入 → 沉淀

1. 素材进入 `Knowledge/Inbox/`
2. AI 处理后分类到对应目录（AI/Business/Personal/Misc）
3. 整理后的笔记合并到正式目录

### 命名规范：文件名 = Canonical Concept

```
一个概念 = 一个文件
```

**正确：** `Transformer.md`（包含 Transformer 的所有知识）
**错误：** `Transformer模型.md`、`Transformer架构详解.md`（知识分裂）

---

## 四、AI-Center WIKI

### 目录结构

AI-Center 按**是否独立运行**分为 7 类：

| 分类 | 说明 |
|------|------|
| `services/` | 常驻进程服务（hermes, hindsight, searxng, self-evolution, sessions-backup） |
| `tools/` | 按需调用工具（whisper, edge-tts, fal-ai, search-tools） |
| `platforms/` | 外部集成平台（feishu, wechat, minimax, volcengine, openclaw） |
| `infrastructure/` | 基础设施（tailscale, oracle-cloud） |
| `docs/` | 系统文档（拓扑图、设计说明、README） |
| `credentials/` | 敏感凭证 |
| `config/` | 配置文件 |

### 快速索引

📍 **WIKI-索引.md** — 按分类组织，点击目录名可跳转。
入口：`AI-Center/docs/WIKI-索引.md`

### 服务文件夹规范

每个服务文件夹包含：

| 内容 | 说明 |
|------|------|
| README.md | 功能、配置、生态作用、使用说明、官网/文档 |
| 迭代记录 | 每次变更的日期和操作 |

---

## 五、会话存档体系

### 三层架构

```
原始会话目录
├── ~/.hermes/sessions/          ← Hermes live sessions（9个）
└── ~/.openclaw/.../sessions/    ← OpenClaw live sessions（43个）

    ↓ 每小时 session-backup.py
热备: /home/shin/sessions/         ← hermes/ + openclaw/，按日期分组
    ↓ 每小时 sessions-git-backup.sh
GitHub: praxistech2026-eng/sessions-backup ← 增量 tar.zst 包
    ↓ 每日 sessions-to-hindsight.py
Hindsight PostgreSQL              ← 向量库，Agent 实时检索
```

### 过滤策略

| 类型                    | 处理                              |
| --------------------- | ------------------------------- |
| 自动化心跳（platform: cron） | 写入 `heartbeat.log`，不进 Hindsight |
| 全量存档                  | 都进热备 + Git 冷备                   |
| 有价值会话                 | 进不是入 Hindsight 向量库              |

### 索引文件

- `manifest.json` — 热备文件索引（Git 追踪）
- `hindsight_imported.json` — Hindsight 导入记录（增量去重）

### 备份脚本

| 脚本 | 功能 | 触发 |
|------|------|------|
| `/home/shin/bin/session-backup.py` | 增量备份到热备目录 | 每小时 |
| `/home/shin/bin/sessions-git-backup.sh` | 打包推送 GitHub | 每小时 |
| `/home/shin/bin/sessions-to-hindsight.py` | 导入 Hindsight 向量库 | 每日 |

---

## 六、同步机制

### 服务端
- 每分钟自动检测变更，推送 GitHub
- Session 归档独立冷备到 `sessions-backup` 仓库

### Mac 端
- Obsidian Git 插件自动 pull/push
- 无需手动操作

---

## 七、常见问题

**Q：Obsidian 里能看到 AI-Center 吗？**
A：能。`AI-Center/` 和 `Knowledge/` 同级，都在 vault 里。

**Q：为什么有两个 Inbox？**
A：历史遗留，已合并到 `Knowledge/Inbox/`。

**Q：MergeQueue 和 Archive 是什么？**
A：历史遗留目录，待后续整理是否保留。
