# Mac CLI版 Tailscale 配置记录

## 背景
目标是在 Mac 上不安装 Tailscale GUI App，仅通过 CLI 使用 Tailscale，并实现开机自动可用。

## 最终方案
采用 macOS `LaunchDaemon` 方式，以 root 权限常驻运行 `tailscaled`，实现完整功能模式（非 userspace 模式）。

## 关键结论
- 不使用 Tailscale App
- 不使用 Homebrew 的用户级 `brew services` 方案
- 使用系统级 `LaunchDaemon`
- `tailscaled` 以 root 启动
- 使用默认 socket：`/var/run/tailscaled.socket`
- 状态文件：`/Library/Tailscale/tailscaled.state`

## 最终状态
- LaunchDaemon 已成功运行
- `tailscale status` 可直接使用
- `tailscale ping shin` 验证成功
- Mac 已能通过 CLI 正常接入 Tailnet
- 已实现开机自动可用，无需每次手动启动

## 关键配置
### LaunchDaemon
- 路径：`/Library/LaunchDaemons/com.shin.tailscaled.plist`

### 状态目录
- `/Library/Tailscale/`

### 日志文件
- `/Library/Tailscale/tailscaled.log`

### Socket
- `/var/run/tailscaled.socket`

## 验证结果
执行：

```bash
sudo launchctl print system/com.shin.tailscaled
ls -l /var/run/tailscaled.socket
tailscale status
tailscale ping shin
```

结果：
- daemon 状态为 `running`
- socket 正常存在
- Tailnet 节点状态正常
- `tailscale ping shin` 成功返回 `pong`

## 当前节点信息
- Linux 服务器节点：`shin`
- Linux 节点 IP：`100.113.209.2`
- 当前 Mac 在线节点：`wangxindemacbook-pro`
- 当前 Mac 节点 IP：`100.114.100.50`
- 最终节点名：`wangxindemacbook-pro`

## 节点整理结果
### 旧节点
旧的 offline 节点已删除。

### 当前在线节点
- `wangxindemacbook-pro`
- IP：`100.114.100.50`

### 如需再次设置节点名
```bash
tailscale set --hostname=wangxindemacbook-pro
```

如需同步 macOS 主机名：

```bash
sudo scutil --set HostName wangxindemacbook-pro
sudo scutil --set LocalHostName wangxindemacbook-pro
sudo scutil --set ComputerName "wangxindemacbook-pro"
```

## 踩坑记录
### 1. Homebrew 服务方式不可直接用
`brew services start tailscale` 启动的是用户级服务，`tailscaled` 需要 root，导致启动失败。

### 2. userspace 模式虽然能跑，但不是目标方案
`--tun=userspace-networking` 可以绕过 root/TUN 限制，但不属于完整功能模式。

### 3. `/run` 路径在 macOS 上不适合作为手动方案
尝试手动指定 `/run/tailscale/tailscaled.sock` 时会遇到目录和只读限制，不适合作为最终落地方案。

### 4. 旧 socket / 旧进程残留会导致 daemon 启动失败
报错特征：

```text
safesocket.Listen: /var/run/tailscaled.socket: address already in use
```

处理方式：
- 停止 LaunchDaemon
- 杀掉残留 `tailscaled`
- 删除旧 socket
- 重新 `bootstrap` / `kickstart`

## 日常使用
常用命令：

```bash
tailscale status
tailscale ping shin
tailscale ssh shin
```

## 关联笔记
- [[AI-Center-拓扑图]]
- [[macOS-CLI版-Tailscale-安装说明]]
