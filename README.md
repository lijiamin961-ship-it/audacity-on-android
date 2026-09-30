# Audacity on Android

> 在安卓手机上跑 Audacity 的零基础方案。
> 适用场景：老师布置了混响/剪辑作业，但身边只有安卓手机。

---

## 为什么需要这个

Audacity 是免费开源的音频编辑工具，但**官方没有安卓版**。本项目用 [Termux](https://termux.dev/) + proot Ubuntu 在安卓设备上跑 Audacity 3.7.9（4.0 没有 ARM64 版，所以用 3.7.9）。

适合：

- 老师布置了混响/剪辑作业但只有安卓手机
- 在外面临时想处理音频但没电脑
- 想低成本体验 Audacity 全部功能

---

## 30 秒版（先上车）

如果你只想"跑起来 + 导出 MP3"，三步：

1. **装 Termux**：F-Droid 版（Play 商店版已停更，会失败）
2. **一行安装**：复制下面这行到 Termux，回车（中途弹窗点「允许」）
   ```bash
   curl -fsSL https://raw.githubusercontent.com/lijiamin961-ship-it/audacity-on-android/main/install.sh -o install.sh && bash install.sh
   ```
3. **启动**：安装完依次输入
   ```bash
   proot-distro login ubuntu
   audacity
   ```
4. **导出**：在 Audacity 里点导出，文件名框**必须写完整路径**，否则你找不到文件——
   ```
   /data/data/com.termux/files/home/storage/downloads/你的文件名.mp3
   ```

> **重要：第 3 步那个路径，是这个教程最值钱的一行。** 我当初就是踩这里卡了两小时。

---

## 完整步骤

### 1. 准备
- 安卓平板或手机（Android 7+ 均可，推荐使用安卓平板，更方便，页面好操作一些）
- 至少 500MB 存储（装完 Ubuntu + Audacity 约 400MB）
- 安装时需联网，之后可离线

### 2. 装 Termux
- F-Droid 下载 Termux（不推荐 Play 商店的版本，已停止维护）
- 打开后会自动初始化包管理器

### 3. 装 proot Ubuntu（在你的安卓里跑一个 Linux）
```bash
pkg update && pkg upgrade -y
pkg install proot-distro -y
proot-distro install ubuntu
proot-distro login ubuntu
```
登录 Ubuntu 后行首会从 `~ $` 变成 `root@localhost:~#`。

### 4. 装 Audacity 3.7.9（在 Ubuntu 里）
```bash
apt update && apt install -y audacity ffmpeg
```
> **注：Audacity 3.7.9 是最后一个支持 ARM64 的版本**。装 4.0+ 会失败。

### 5. 启动 Audacity
```bash
audacity
```
**首次启动会比较慢**（约 5-10 秒）。第二次就快了。

---

## 我踩过的两个坑

### 坑 1：导出音频后找不到文件 ⚠️

Audacity 默认保存到 Linux 家目录（`/root/`），**但安卓的文件管理器看不到这个路径**。

**解决**：导出对话框里，文件名框**必须写完整路径**：

```
/data/data/com.termux/files/home/storage/downloads/你的混响.mp3
```

或者保存后运行（推荐）：

```bash
cp -u ~/*.mp3 ~/storage/downloads/
```

一键安装脚本已自动布置好 `move.sh`，跑完任务执行它就行：

```bash
bash ~/move.sh
```

### 坑 2：触控笔没反应

诊断步骤：

1. 用**系统备忘录**画画 → 如果没反应，是硬件问题
2. 在 Audacity 顶部菜单 → **Edit → Preferences → Devices → Toolbars → Mouse** 中切换 `Stylus` / `Touch` / `2-finger`
3. 重启 Audacity

---

## 这个仓库里有什么

- `README.md` — 本教程
- `install.sh` — 一键安装脚本（Termux 里跑）

---

## License

MIT — 随便用，记得保留原作者信息。

---

## 致谢

- Termux 项目
- Audacity 项目
- 所有贡献者（欢迎在 Issues 提 bug / 在 Discussions 聊）

---

> **关于这个 README 本身**：本项目遵循"成人世界赢只需 51 分"原则——**先发布，再迭代**。如果你看到这里觉得"还不够好"，欢迎直接 PR 完善它。