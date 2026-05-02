# macOS-CLI版-Tailscale-安装说明

## 目标
在 macOS 上：
- 不安装 Tailscale GUI App
- 仅通过 CLI 使用 Tailscale
- 使用完整功能模式（非 userspace）
- 开机自动启动
- 可直接使用 `tailscale status` / `tailscale ping` / `tailscale ssh`

---

## 1. 安装
```bash
brew install tailscale
```

确认路径：

```bash
which tailscaled
which tailscale
```

通常为：
- `/usr/local/bin/tailscaled`
- `/usr/local/bin/tailscale`

---

## 2. 停掉 Homebrew 用户级服务
不要使用 `brew services` 作为最终方案：

```bash
brew services stop tailscale
```

---

## 3. 创建状态目录
```bash
sudo mkdir -p /Library/Tailscale
```

---

## 4. 创建 LaunchDaemon
写入 plist：

```bash
cat > /tmp/com.shin.tailscaled.plist <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.shin.tailscaled</string>

  <key>ProgramArguments</key>
  <array>
    <string>/usr/local/bin/tailscaled</string>
    <string>--state=/Library/Tailscale/tailscaled.state</string>
  </array>

  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>

  <key>StandardOutPath</key>
  <string>/Library/Tailscale/tailscaled.log</string>
  <key>StandardErrorPath</key>
  <string>/Library/Tailscale/tailscaled.log</string>
</dict>
</plist>
EOF
```

部署到系统目录：

```bash
sudo mv /tmp/com.shin.tailscaled.plist /Library/LaunchDaemons/com.shin.tailscaled.plist
sudo chown root:wheel /Library/LaunchDaemons/com.shin.tailscaled.plist
sudo chmod 644 /Library/LaunchDaemons/com.shin.tailscaled.plist
plutil -lint /Library/LaunchDaemons/com.shin.tailscaled.plist
```

---

## 5. 清理旧残留（重要）
如果以前手动跑过 `tailscaled`，先清理：

```bash
sudo launchctl bootout system /Library/LaunchDaemons/com.shin.tailscaled.plist 2>/dev/null || true
sudo pkill -f tailscaled 2>/dev/null || true
pkill -f tailscaled 2>/dev/null || true
sudo rm -f /var/run/tailscaled.socket
rm -f ~/.tailscale/tailscaled.sock
```

---

## 6. 启动 LaunchDaemon
```bash
sudo launchctl bootstrap system /Library/LaunchDaemons/com.shin.tailscaled.plist
sudo launchctl kickstart -k system/com.shin.tailscaled
```

检查状态：

```bash
sudo launchctl print system/com.shin.tailscaled
ls -l /var/run/tailscaled.socket
```

成功标志：
- `state = running`
- `/var/run/tailscaled.socket` 存在

---

## 7. 登录 Tailscale
```bash
tailscale login
```

如果能访问 daemon，会返回登录 URL，用浏览器完成授权即可。

---

## 8. 设置 operator（推荐）
让当前用户以后不必每次 sudo：

```bash
sudo tailscale up --operator=$(whoami)
```

---

## 9. 验证
```bash
tailscale status
tailscale ping <你的另一台节点名>
tailscale ssh <节点名>
```

---

## 10. 常见问题

### 问题 1
```text
Failed to connect to local Tailscale daemon
```

原因：
- `tailscaled` 没启动
- socket 不存在
- 启动方式不对

排查：

```bash
sudo launchctl print system/com.shin.tailscaled
ls -l /var/run/tailscaled.socket
sudo tail -100 /Library/Tailscale/tailscaled.log
```

### 问题 2
```text
safesocket.Listen: /var/run/tailscaled.socket: address already in use
```

原因：
- 旧进程或旧 socket 残留

处理：

```bash
sudo pkill -f tailscaled
sudo rm -f /var/run/tailscaled.socket
sudo launchctl bootstrap system /Library/LaunchDaemons/com.shin.tailscaled.plist
sudo launchctl kickstart -k system/com.shin.tailscaled
```

### 问题 3
```text
tailscaled requires root
```

原因：
- 你在用用户级方式运行完整模式 daemon

正确做法：
- 用 `LaunchDaemon`
- 不用 `brew services` 作为最终完整模式方案

---

## 11. 日常使用
```bash
tailscale status
tailscale ping <node>
tailscale ssh <node>
```

---

## 12. 最终结论
macOS 上可以不安装 Tailscale App，仅使用 CLI 达成完整功能模式；稳定做法是：
- root 级 `LaunchDaemon`
- 默认 `/var/run/tailscaled.socket`
- 默认 `/Library/Tailscale/tailscaled.state`
- 当前验证节点名：`wangxindemacbook-pro`
- 当前验证节点 IP：`100.114.100.50`

## 关联笔记
- [[Mac-CLI版-Tailscale-配置记录]]
- [[AI-Center-拓扑图]]
