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

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | 接入作为备选模型 |
