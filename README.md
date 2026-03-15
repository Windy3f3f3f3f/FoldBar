# FoldBar

**A lightweight macOS menu bar manager. Hide icons with one click. | 轻量级 macOS 菜单栏管理工具，一键折叠图标。**

![macOS 12+](https://img.shields.io/badge/macOS-12%2B-blue) ![MIT License](https://img.shields.io/badge/license-MIT-green) ![Swift](https://img.shields.io/badge/Swift-5.7-orange)

![Screenshot](screenshot.png)

---

## Why FoldBar? / 为什么需要 FoldBar？

MacBook Pro's notch hides menu bar icons when there are too many of them. FoldBar lets you fold away the icons you don't need, keeping your menu bar clean and usable.

MacBook Pro 的刘海屏会遮挡过多的菜单栏图标，导致部分图标无法显示。FoldBar 帮你折叠不常用的图标，让菜单栏保持整洁可用。

---

## Features / 功能

- **One click to fold/unfold** menu bar icons — 一键折叠/展开菜单栏图标
- **Auto-collapse** with configurable delay — 可设定延迟的自动折叠
- **137 lines of code**, single file, zero dependencies — 137 行代码，单文件，零依赖
- **No permissions required** — 无需任何系统权限
- **Launch at login** support — 支持开机自启
- **Notch-friendly** — perfect for MacBook Pro with notch — 完美解决刘海屏图标遮挡问题

---

## Install / 安装

### **[>>> Download FoldBar.app <<<](https://github.com/Windy3f3f3f3f/FoldBar/releases/latest)**

> **下载后直接拖入 Applications 文件夹即可使用，无需其他操作。**
>
> Just download, drag to Applications, and run. No setup needed.

---

## Usage / 使用说明

1. **Drag the toggle arrow**: Hold `Cmd` and drag `◀` to the right side of your menu bar
   — 按住 `⌘` 将 `◀` 拖到菜单栏靠右的位置

2. **Place the separator**: Hold `Cmd` and drag `┃` to the left of `◀`
   — 按住 `⌘` 将 `┃` 拖到 `◀` 左边

3. **Hide icons**: Hold `Cmd` and drag any icon you want to hide to the left of `┃`
   — 按住 `⌘` 将想隐藏的图标拖到 `┃` 左边

4. **Toggle**: Click `◀` to collapse, click `▶` to expand
   — 点击 `◀` 折叠，点击 `▶` 展开

**Right-click** the toggle for preferences (auto-collapse timer).
右键点击箭头可打开设置（自动折叠计时器）。

---

## Build from Source / 从源码构建

Requires Swift 5.7+ and macOS 12+.

```bash
git clone https://github.com/Windy3f3f3f3f/FoldBar.git
cd FoldBar
chmod +x build.sh
./build.sh
open FoldBar.app
```

Or use Swift Package Manager directly:

```bash
swift build -c release
```

---

## Acknowledgements / 致谢

Inspired by [Hidden Bar](https://github.com/dwarvesf/hidden).

---

## License

[MIT](LICENSE)
