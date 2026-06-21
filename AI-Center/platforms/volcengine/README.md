# Volcengine ARK

> 字节跳动火山引擎 ARK API，提供 DeepSeek-V3.2 和 Doubao-seed 等免费模型。

## 官方资源

| 资源 | 链接 |
|------|------|
| ARK 官网 | https://www.volcengine.com/product/ark |
| API 文档 | https://www.volcengine.com/product/ark |

## 在本生态中的角色

**备选模型**。当 MiniMax 不可用或需要测试其他模型时使用。DeepSeek-V3.2 和 Doubao-seed-2.0-code/pro 可通过 ARK API 访问。

## 接入配置

```
API Endpoint: https://ark.cn-beijing.volces.com/api/coding/v3
认证: Bearer API Key
```

> 凭证保存在 `~/.hermes/.env` 的 `ARK_API_KEY`

## 内置模型

| 模型 | 用途 |
|------|------|
| ark-code-latest | 自动路由最新代码模型 |
| DeepSeek-V3.2 | 主力备选 |
| Doubao-seed-2.0-code | 代码专项 |
| Doubao-seed-2.0-pro | 高端推理 |

## 成本

> 免费（火山引擎编程计划）

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | 火山引擎 ARK API 配置与 `ARK_API_KEY` | 无本地进程 |
| 检查命令 | `hermes config check`；执行一次最小模型调用 | 以成功调用为准 |
| 判据 | 能完成一次 ARK 调用 | 凭证可用 |
| 频率 | 改 key / 改路由 / 改模型后 | 变更即查 |
| 失败动作 | 先核验 key、模型是否可用，再切回 MiniMax 或别的备选 | 先保可用 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `ARK_API_KEY`、模型路由、常用模型名 | 核心是 key 和路由 |
| 备份方式 | `.env` + Git 非敏感配置 | 不写明文 |
| 频率 | 改动前 | 凭证先备份 |
| 保留策略 | 保留最近可回滚版本 | 足够恢复 |
| 恢复命令 | 恢复 key 后重新调用 | 回滚后验 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | 鉴权失败、模型不可用、调用失败 | 任一即异常 |
| 通知渠道 | 暂未接入独立自动告警 | 现由巡检/人工发现补位 |
| 兜底动作 | 切回主模型或其他备选提供商 | 先保可用 |
| 升级路径 | 先恢复调用，再检查路由 | 不硬扛 |

### 恢复 / 回滚

- 恢复 `ARK_API_KEY`
- 必要时回退到 MiniMax 主路由

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 接入作为备选模型 |
