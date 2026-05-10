# SearXNG

> 隐私优先的元搜索聚合引擎，聚合多个搜索服务的结果，不追踪不画像用户。

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub | https://github.com/searxng/searxng |
| 官方文档 | https://docs.searxng.org/ |
| Docker 安装 | https://docs.searxng.org/admin/installation-docker.html |

## 功能

- **隐私优先**：不追踪不画像用户，支持无痕搜索
- **多引擎聚合**：可配置百度、Google、Bing、Wikipedia 等数十个搜索引擎
- **多格式输出**：支持 JSON/API 响应
- **图片代理**：可选内置图片代理
- **反爬保护**：可选请求限流和反爬机制

## 在本生态中的角色

**搜索基础设施**。SearXNG 是 AI Center 的主力搜索聚合引擎，Hermes 通过 SearXNG 获取实时网络信息。

## 部署信息

| 属性 | 值 |
|------|-----|
| Docker 镜像 | `ghcr.io/searxng/searxng` |
| 容器端口 | 7777 |
| 访问地址 | `http://127.0.0.1:7777` |
| 配置卷 | `/home/shin/docker/searxng/config:/etc/searxng` |
| 配置文件 | `settings.yml` |

## 关键配置（settings.yml）

```yaml
use_default_settings: true

server:
  port: 7777
  bind_address: "0.0.0.0"
  secret_key: "<生成随机密钥>"
  limiter: false
  image_proxy: true

search:
  safe_search: 0
  autocomplete: "google"
  default_lang: "zh-CN"
  formats:
    - html
    - json
```

## 常用命令

```bash
# 健康检查
curl "http://127.0.0.1:7777/healthz"

# 搜索示例
curl "http://127.0.0.1:7777/search?q=关键词&format=json"

# 搜索建议
curl "http://127.0.0.1:7777/?q=test&format=json&categories=general"
```

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-04 | Docker 部署，修复端口 8787→7777 |
