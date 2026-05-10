# 搜索工具矩阵

> AI Center 的搜索工具集合，覆盖精准单页抓取、大规模批量爬取、复杂反爬绕过、高匿名隐身浏览。

## 工具概览

| 工具 | 类型 | 用途 |
|------|------|------|
| Jina Reader | Skill | 单页精准抓取，干净 Markdown |
| Crawl4AI | Skill | 批量深度爬取，异步并行，JS 渲染 |
| Scrapling | pip | 复杂反爬，多引擎自适应解析 |
| CamoFox | pip | 高匿名隐身浏览器，指纹隐藏 |
| DuckDuckGo | CLI | 免费零成本兜底 |
| Tavily | pip | AI 语义优化搜索 |

## Jina Reader

| 属性 | 值 |
|------|-----|
| API Endpoint | `https://r.jina.ai/<url>` |
| 脚本 | `~/scripts/jina-read` |
| 认证 | Bearer Token（`jinja_` 开头） |
| 定位 | 单页快速抓取，内容质量高 |

## Crawl4AI

| 属性 | 值 |
|------|-----|
| Python 包 | `crawl4ai` v0.8.6 |
| 前置要求 | `playwright install chromium` |
| 定位 | 批量 URL、深层爬取、JS 渲染、LLM 过滤 |

## Scrapling

| 属性 | 值 |
|------|-----|
| Python 包 | `scrapling` v0.2.99 |
| 引擎 | Fetcher(httpx) / StealthyFetcher(Camoufox) / PlayWrightFetcher |
| 定位 | 复杂反爬场景，自适应解析 |

## CamoFox

| 属性 | 值 |
|------|-----|
| Python 包 | `camoufox` v0.4.11 |
| CLI | `~/.local/bin/camoufox` |
| 定位 | 最严格反爬，完整浏览器指纹隐藏 |

## DuckDuckGo

| 属性 | 值 |
|------|-----|
| 工具 | `ddgs` CLI |
| 定位 | 免费零成本兜底，隐私敏感时用 |

## Tavily

| 属性 | 值 |
|------|-----|
| Python 包 | `tavily` v0.7.24 |
| 限制 | 1000次/月免费额度 |
| 定位 | AI 语义优化搜索 |

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 接入完整搜索工具矩阵 |
