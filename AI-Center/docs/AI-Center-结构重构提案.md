# AI Center 档案库结构重构提案

> 状态：提案稿，待确认后进入实施。
>
> 目标：把当前 AI Center 从“能找文件”升级成“新人可接班、服务可维护、故障可恢复、状态可巡检”的运维型档案库。
>
> 核心原则：
> 1. **先核实事实，再改文档。**
> 2. **实时状态写 Homepage / 巡检，长期事实写档案库。**
> 3. **WIKI 索引保留为统一入口。**
> 4. **拓扑图必须体现组织关系，不再只是服务堆叠。**
> 5. **凭证允许明文，但必须有强警告：这是内网档案库，不许推 Git。**

---

## 一、当前结构的主要问题

### 1. 总览、拓扑、WIKI 职责混杂
现在的 `docs/README.md`、`docs/AI-Center-拓扑图.md`、`docs/WIKI-索引.md` 同时承担：
- 导航入口
- 系统说明
- 运行状态
- 依赖关系
- 历史日志
- 凭证摘录

这会导致文档非常容易漂移，也让新人难以判断“哪些是长期事实，哪些是当前快照”。

### 2. 拓扑图不体现组织关系
当前拓扑图更多是“服务盒子堆叠图”，而不是：
- 入口层
- 门户层
- 服务层
- 模型网关层
- 数据层
- 备份层
- 通知层

因此看不出：
- 谁依赖谁
- 谁是入口
- 谁是控制面
- 哪些是实时状态，哪些是长期档案

### 3. 凭证总表覆盖不足
`credentials/系统凭证备忘录.md` 目前还偏窄，缺少：
- 全量 LLM provider 凭证
- 服务账号与密码
- 数据库凭证
- 平台账号
- 运维工具账号
- 失效/已替换/已弃用状态

### 4. 服务文档缺少统一运维结构
很多服务只有 README，没有形成：
- USAGE_MANUAL
- RUNBOOK
- 搭建纪要
- CHANGELOG

### 5. 巡检与 Homepage 还未形成门户级体验
现在已经有 watchdog 和 Homepage，但：
- 巡检还不够全面
- Homepage 还是偏导航页
- 没有把“服务状态 + 模型状态 + 链路状态 + 资源状态”聚合到一个视图里

---

## 二、建议的新结构

### 2.1 推荐目录树

```text
AI-Center/
├── docs/
│   ├── README.md
│   ├── WIKI-索引.md
│   ├── AI-Center-拓扑图.md
│   ├── AI-Center-结构重构提案.md
│   ├── AI-Center-阶段执行提示词.md
│   ├── AI-Center-档案库整理计划.md
│   ├── 00-系统导论.md
│   ├── 运维体系总册.md
│   ├── 变更管理流程.md
│   ├── 巡检与告警体系.md
│   ├── 首页门户说明.md
│   └── 历史快照/
│
├── services/
│   ├── hermes/
│   ├── hindsight/
│   ├── searxng/
│   ├── n8n/
│   ├── alist/
│   ├── litellm/
│   └── sessions-backup/
│
├── platforms/
│   ├── openclaw/
│   ├── feishu/
│   ├── wechat/
│   ├── minimax/
│   ├── volcengine/
│   └── ...
│
├── infrastructure/
│   ├── tailscale/
│   ├── oracle-cloud/
│   ├── server-host/
│   └── network/
│
├── credentials/
│   ├── 系统凭证备忘录.md
│   ├── LLM-厂商配置基线.md
│   ├── LiteLLM-模型配置方法.md
│   ├── LLM-模型可用性快照-YYYY-MM-DD.md
│   └── 历史快照/
│
├── operations/
│   ├── 巡检项总表.md
│   ├── 告警分级标准.md
│   ├── 备份恢复标准.md
│   ├── 故障处理总则.md
│   └── 服务接入流程.md
│
├── homepage/
│   ├── homepage-services.yaml
│   ├── homepage-bookmarks.yaml
│   └── status/
│
├── config/
└── skills-system/
```

### 2.2 目录职责

#### docs/
只放全局说明、方法论、总览、结构、索引、历史快照。

#### services/
放本地常驻服务。
每个服务目录必须逐步补齐：
- README.md
- USAGE_MANUAL.md
- 搭建纪要.md
- RUNBOOK.md
- CHANGELOG.md

#### platforms/
放外部平台集成和对接层，例如 Feishu / WeChat / MiniMax / Volcengine / OpenClaw。

#### infrastructure/
放宿主机、网络、Tailscale、Oracle Cloud 等基础设施。

#### credentials/
放所有可记录的账号、密码、Key、地址、端口、用户名、来源、失效状态。

#### operations/
放巡检、告警、备份、恢复、故障处理、接入流程等运维标准。

#### homepage/
放静态导航与状态面板文件，必要时配合 watchdog 写入状态输出。

---

## 三、文档分类规则

### 3.1 长期事实写档案库
应写入档案库的内容：
- 服务是什么
- 为什么这么搭
- 端口与入口
- 账号与密码
- 数据目录
- 备份与恢复
- 故障处理
- 选型理由
- 变更历史

### 3.2 实时状态写 Homepage / 巡检
不写入长期档案库的内容：
- PID
- 当前是否 running / not-running 的短期波动
- 临时限流
- 临时 401 / 429
- 最近一次巡检状态
- 瞬时资源使用率

### 3.3 历史快照单独归档
适合单独快照的内容：
- LLM model 可用性快照
- 大范围换 key / 换套餐
- 服务重大重构前后对比
- 巡检体系升级前后对比

---

## 四、拓扑图重构原则

### 4.1 必须表达的层级
拓扑图建议至少分为：
1. 入口层
2. 门户层
3. 服务层
4. LLM 网关层
5. 数据层
6. 备份层
7. 通知层
8. 外部平台层

### 4.2 拓扑图里不要再放的东西
以下内容不建议继续放在拓扑图正文里：
- PID
- 临时健康分
- 过期 model 快照
- 具体 token 片段
- 明文凭证摘录

这些内容应迁移到：
- README 的基础信息表
- credentials/
- 历史快照
- Homepage / watchdog

### 4.3 拓扑图建议采用“双表达”
- **Mermaid**：展示依赖关系
- **ASCII 简图**：便于快速扫读
- **关系表**：服务、角色、入口、依赖、状态、说明

---

## 五、服务文档归档标准的落地方式

### 5.1 标准归档项
每个服务最终应形成：
- README.md
- USAGE_MANUAL.md
- 搭建纪要.md
- RUNBOOK.md
- CHANGELOG.md

### 5.2 优先级建议
先补核心服务：
1. Hermes / OpenClaw
2. Hindsight
3. LiteLLM
4. Homepage / watchdog 相关
5. n8n
6. SearXNG
7. AList

### 5.3 低复杂度服务的处理
简单服务可以先把 `USAGE_MANUAL` 写进 README，后续再拆独立文件，但最终目标仍是统一成归档标准。

---

## 六、巡检与 Homepage 的关系

### 6.1 巡检负责什么
- 主机资源
- Docker / 进程
- HTTP 健康
- LLM model 健康
- 备份新鲜度
- 关键链路可达性

### 6.2 Homepage 负责什么
- 导航入口
- 当前运行状态
- 关键服务健康摘要
- 大模型健康摘要
- 关键链路状态

### 6.3 规则
- 高频波动不进档案库
- 巡检失败才告警
- Homepage 展示“足够判断是否介入”的信息

---

## 七、变更管理规则

每次变更都要触发以下动作：
1. 更新对应服务 README
2. 更新凭证总册（如涉及 key / 账号 / 密码）
3. 更新 WIKI 索引
4. 更新拓扑图或总览
5. 更新变更记录 / 历史快照
6. 如涉及监控，更新 watchdog / Homepage 状态面

---

## 八、实施顺序建议

1. 阶段 0：现状体检
2. 阶段 1：结构规划
3. 阶段 2：拓扑图与总览重画
4. 阶段 3：凭证体系重写
5. 阶段 4：服务档案标准补齐
6. 阶段 5：巡检与 Homepage 门户化
7. 阶段 6：变更流程收口

---

## 九、需要你确认的默认决策

### 9.1 我建议默认采用的原则
- **OpenClaw 继续放在 `platforms/`**：它更像执行/集成层，不是普通服务进程
- **LiteLLM 建独立服务目录**：它现在已经是核心控制面，不应只挂在 credentials 下
- **README + 独立 USAGE_MANUAL 双轨并行**：先保证可维护，再逐步统一
- **WIKI 继续保留**：作为唯一总索引入口
- **实时状态和长期事实严格分离**：状态交给 Homepage / watchdog，档案库只写长期事实

### 9.2 已确认的结构决策

- `operations/`：**独立顶层目录**，专门放巡检项、告警分级、备份恢复、故障处理、服务接入流程。
- `homepage/`：**正式纳入 AI Center 归档**，作为门户与状态展示的正式组成部分。
- `services/litellm/`：**正式建目录**，不再只挂在 `credentials/` 下作为配置附属。

---

## 十、结论

当前 AI Center 不是“内容少”，而是“结构边界不清”。
这份提案的核心目标是：
- 让新人看得懂
- 让运维能接班
- 让巡检和 Homepage 成为实时层
- 让档案库只保留长期事实
- 让拓扑图真正反映系统组织关系
