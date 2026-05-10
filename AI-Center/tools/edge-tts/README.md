# Edge TTS

> 微软 Edge 浏览器的语音合成服务，本地调用，免费高质量中文 TTS。

## 官方资源

| 资源 | 链接 |
|------|------|
| PyPI | https://pypi.org/project/edge-tts/ |
| 微软官方 TTS 文档 | https://learn.microsoft.com/en-us/azure/ai-services/speech-service/text-to-speech |

## 功能

- **免费使用**：无需 Azure 账号
- **高质量神经网络语音**：支持中文
- **多语言**：40+ 语言
- **SSML 支持**：可精细控制语速、音调、情感

## 在本生态中的角色

**语音合成层**。Edge TTS 是 AI Center 的本地 TTS 引擎，用于将 Agent 回复转为语音输出。

## 部署信息

| 属性 | 值 |
|------|-----|
| Python 包 | `edge-tts` v7.2.8 |
| 中文语音 | `zh-CN-XiaoxiaoNeural`（女声，温暖） |
| 使用方式 | Hermes 内置工具 `text_to_speech` |

## 常用命令

```bash
# 测试语音合成
edge-tts -t "你好，我是 Shin" -v zh-CN-XiaoxiaoNeural -f test.mp3

# 列出可用语音
edge-tts --list-voices | grep zh-CN
```

## 迭代记录

| 日期 | 操作 |
|------|------|
| 2026-05 | 部署完成 |
