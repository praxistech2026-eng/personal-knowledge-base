# Whisper

> OpenAI 开源的 99+ 语言语音识别模型，本地部署。

## 官方资源

| 资源 | 链接 |
|------|------|
| GitHub (OpenAI) | https://github.com/openai/whisper |
| Python 包 | `openai-whisper` (pip) |

## 功能

- **99+ 语言识别**：支持普通话、英语、日语、韩语等
- **多模型规格**：tiny / base / small / medium / large
- **本地推理**：无需联网，保护隐私
- **字幕生成**：可输出 SRT/VTT 格式

## 在本生态中的角色

**语音识别层**。Whisper 是 AI Center 的本地 ASR 引擎，用于将语音输入转为文字，供 Agent 处理。

## 部署信息

| 属性 | 值 |
|------|-----|
| 模型 | base（72M 参数，约 139MB） |
| Python 包 | `openai-whisper` |
| venv | `~/.hermes/hermes-agent/venv/bin/` |
| 使用方式 | Hermes 内置工具 `transcribe_audio` |

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署 base 模型 |
