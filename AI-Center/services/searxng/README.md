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
| 容器端口 | 8080（容器内）→ 7777（主机映射） |
| 访问地址 | `http://127.0.0.1:7777` |
| 配置卷 | `/home/shin/docker/searxng/config:/etc/searxng` |
| 配置文件 | `settings.yml` |
| 运行状态 | 🟢 运行中（2026-06-15 拉起，7777 实测 200） |

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

## USAGE_MANUAL

### 健康检查

| 字段 | 值 | 说明 |
|------|----|------|
| 检查对象 | `127.0.0.1:7777` | 容器服务 |
| 检查命令 | `curl -s http://127.0.0.1:7777/healthz`；`ss -tlnp | grep 7777` | 健康端点与端口 |
| 判据 | `healthz` 可访问且 7777 监听 | 服务在线 |
| 频率 | 启动后 / 改配置后 / 巡检时 | 变更即查 |
| 失败动作 | 查容器与 `settings.yml`，再重启容器 | 先配置后容器 |

### 备份

| 字段 | 值 | 说明 |
|------|----|------|
| 备份对象 | `/home/shin/docker/searxng/config` 与 `settings.yml` | 仅配置需要备份 |
| 备份方式 | 目录归档 / Git 版本化 | 镜像可重拉 |
| 频率 | 改配置前 + 例行 | 变更即备 |
| 保留策略 | 保留最近可回滚版本 | 够回滚即可 |
| 恢复命令 | 恢复 config 目录并重启容器 | 按目录还原 |

### 告警

| 字段 | 值 | 说明 |
|------|----|------|
| 告警条件 | `healthz` 失败、容器退出、配置文件缺失 | 任一即异常 |
| 通知渠道 | 当前未接自动告警 | 先人工巡检 |
| 兜底动作 | 先恢复配置，再检查容器 | 先配置后容器 |
| 升级路径 | 人工介入排障 | 未自动化 |

### 恢复 / 回滚

- 先恢复 `settings.yml`
- 再启动容器并复查 `healthz`

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-06-11 | 实机核验：当前未运行，本机未监听 7777，`docker ps` 未发现 searxng 容器 |
| 2026-06-15 | 实机拉起：SearXNG 容器运行中，`/healthz` 200，端口 7777 监听 |
