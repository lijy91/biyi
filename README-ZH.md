# biyi

[![GitHub (pre-)release](https://img.shields.io/github/release/biyidev/biyi/all.svg?style=flat-square)](https://github.com/biyidev/biyi/releases) [![GitHub (pre-)release](https://img.shields.io/badge/distribute%20with-flutter__distributor-green?style=flat-square)](https://github.com/leanflutter/flutter_distributor)

**比译** 是一个用 Flutter 编写的便捷翻译和词典应用。[查看文档](https://biyidev.com/docs/)

> "Biyi" (比译) is the Chinese word for "Comparison + translation".

---

[English](./README.md) | 简体中文

---

![](https://biyidev.com/images/screenshots/biyi_extract_text_from_screen_selection.gif)

## 平台支持

| Linux | macOS | Windows |
| :---: | :---: | :-----: |
|   ✔️   |   ✔️   |    ✔️    |

## 安装

下载可以在[发布版本](https://github.com/biyidev/biyi/releases/latest)页面上找到，也可以在[网站](https://biyidev.com/release-notes)上找到其他安装方法。

**要用 Homebrew 安装，请运行：**

```bash
brew tap biyidev/biyi
brew install biyi
```

## 开发

我们欢迎您加入比译的开发。

> 在提出 Pull Request 之前，请务必阅读[贡献指南](https://github.com/biyidev/biyi/blob/main/.github/CONTRIBUTING.md)。

### ⚠️ Linux requirements

- `appindicator3-0.1`
- [`keybinder-3.0`](https://github.com/kupferlauncher/keybinder)

运行以下命令

```
sudo apt-get install appindicator3-0.1 libappindicator3-dev
sudo apt-get install keybinder-3.0
```

### 开始之前

1. 创建工作目录

```
$ mkdir ~/biyidev
$ cd ~/biyidev
```

2. 通过 git 克隆代码库：

```
$ git clone https://github.com/biyidev/biyi.git
```

3. 切换到 `biyi` 目录

```
$ cd ~/biyidev/biyi
```

4. 安装依赖项

```
$ flutter pub get
```

### 运行应用

```
$ flutter run -d linux / macos / windows
```

## 讨论

> 欢迎加入讨论组，与我分享你的建议和想法。

- [QQ Group](https://jq.qq.com/?_wv=1027&k=vYQ5jW7y)

## Related Links

- https://github.com/biyidev/biyi
- https://github.com/biyidev/uni_ocr
- https://github.com/biyidev/uni_translate
- https://github.com/leanflutter/hotkey_manager
- https://github.com/leanflutter/screen_text_extractor
- https://github.com/leanflutter/tray_manager
- https://github.com/leanflutter/window_manager

## 许可证

[AGPL](./LICENSE)
