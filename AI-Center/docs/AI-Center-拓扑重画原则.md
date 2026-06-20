# AI Center 拓扑重画原则

> 目标：把现有系统拓扑从“服务堆叠图”升级成“能看出组织关系、入口关系、控制关系、数据关系、运维关系”的系统地图。
>
> 适用范围：`docs/AI-Center-拓扑图.md`、`docs/README.md`、相关服务 README 的总览段。

---

## 1. 拓扑图必须表达的层级

拓扑图至少分成以下层：

1. **入口层**
   - Tailscale、局域网、本机入口
   - 只展示用户如何进入系统

2. **门户层**
   - Homepage
   - 只展示导航与状态，不承载服务逻辑

3. **服务层**
   - Hermes、Hindsight、n8n、SearXNG、AList、LiteLLM 等

4. **LLM 网关层**
   - LiteLLM、MiniMax、Bailian、SenseNova、Volcengine、ChatGPT、Gemini

5. **数据层**
   - PostgreSQL、session backup、历史快照、知识库、日志存储

6. **备份层**
   - session-backup、Git 冷备、Hindsight 入库、容灾副本

7. **通知层**
   - 微信、飞书、cron 告警、watchdog 输出

8. **外部平台层**
   - Feishu、WeChat、MiniMax 官方、Volcengine 官方、Oracle Cloud、Tailscale 网络

---

## 2. 组织关系的表达方式

### 2.1 入口关系
要让人一眼知道：
- 从哪里进系统
- 哪些入口是 LAN
- 哪些入口是 tailnet
- 哪些入口只能本机访问
- 哪些是 external / 外部平台

### 2.2 控制关系
要让人一眼知道：
- 谁是控制面
- 谁是执行面
- 谁只是状态展示
- 谁是数据持久层

### 2.3 依赖关系
要让人一眼知道：
- 哪些服务依赖数据库
- 哪些服务依赖 LLM 网关
- 哪些服务依赖外部平台
- 哪些服务只是本地工具，不应画成核心依赖

---

## 3. 拓扑图中不再承担的职责

以下信息**不应继续放在拓扑图正文里**：
- PID
- 临时健康分
- 短期限流状态
- 具体 token 片段
- 短生命周期的运行备注
- 大段调研正文

这些内容应拆分到：
- `README.md`
- `credentials/系统凭证备忘录.md`
- `operations/巡检项总表.md`
- `docs/历史快照/`
- Homepage / watchdog 输出

---

## 4. 拓扑图推荐的三种表达

### 4.1 Mermaid 图
用于展示依赖与流向。

### 4.2 ASCII 快图
用于快速扫读总览。

### 4.3 关系表
推荐字段：
- 名称
- 分层
- 角色
- 入口
- 端口
- 依赖
- 状态
- 备注

---

## 5. 当前系统建议分层

### 5.1 入口层
- Tailscale
- LAN 192.168.2.249
- 本机 127.0.0.1

### 5.2 门户层
- Homepage

### 5.3 服务层
- Hermes API Server
- Hermes WebUI
- OpenClaw Gateway
- Hindsight
- n8n
- SearXNG
- AList
- LiteLLM

### 5.4 LLM 网关层
- LiteLLM
- MiniMax Token Plan
- Bailian Token Plan
- SenseNova
- Volcengine
- ChatGPT
- Gemini

### 5.5 数据层
- PostgreSQL
- session archives
- Hindsight 向量库
- Obsidian vault / PersonalKnowledge

### 5.6 备份层
- session-backup.py
- sessions-git-backup.sh
- Hindsight 入库
- 历史快照

### 5.7 通知层
- 微信
- 飞书
- Hermes cron / watchdog

### 5.8 外部平台层
- Feishu
- WeChat
- MiniMax
- Volcengine
- Oracle Cloud
- Tailscale

---

## 6. 拓扑图重画时的硬性要求

1. **先画关系，再画状态。**
2. **先画分层，再填节点。**
3. **实时状态只写摘要，不写大量细节。**
4. **所有服务状态必须能与实机核验对应。**
5. **README 顶部总览必须与拓扑图一致。**
6. **WIKI 索引必须能点击跳转到真实文件。**
7. **拓扑图中不再写 PID 和临时调试痕迹。**

---

## 7. 后续执行顺序

1. 先把 `docs/AI-Center-拓扑图.md` 按上面的分层重写。
2. 再把 `docs/README.md` 的总览图同步到同一套分层。
3. 然后把 WIKI 索引的入口与总览对齐。
4. 最后再回头清理服务 README 里的过时总览引用。
