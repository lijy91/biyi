# biyi

[![GitHub (pre-)release](https://img.shields.io/github/release/lijy91/biyi/all.svg?style=flat-square)](https://github.com/lijy91/biyi/releases) [![GitHub (pre-)release](https://img.shields.io/badge/distribute%20with-flutter__distributor-green?style=flat-square)](https://github.com/leanflutter/flutter_distributor)

**Biyi** is a convenient translation and dictionary app written in `Flutter`. [View document](https://biyidev.com/docs/)

> "Biyi" (比译) is the Chinese word for "Comparison + translation".

---

English | [简体中文](./README-ZH.md)

---

![](https://biyidev.com/images/screenshots/biyi_extract_text_from_screen_selection.gif)

## Platform Support

| Linux | macOS | Windows |
| :---: | :---: | :-----: |
|  ✔️   |  ✔️   |   ✔️    |

## Installation

Downloads are available on the [Releases](https://github.com/lijy91/biyi/releases/latest) page. Also check out the [website](https://biyidev.com/release-notes) for other installation methods.

**To install with Homebrew, run:**

```bash
brew tap lijy91/biyi
brew install biyi
```

## Development

We welcome you to join the development of `Biyi`.

> Please make sure to read the [Contributing Guide](https://github.com/lijy91/biyi/blob/main/.github/CONTRIBUTING.md) before making a pull request.

### ⚠️ Linux requirements

- `appindicator3-0.1`
- [`keybinder-3.0`](https://github.com/kupferlauncher/keybinder)

Run the following command

```
sudo apt-get install appindicator3-0.1 libappindicator3-dev
sudo apt-get install keybinder-3.0
```

### Before You Start

1. Clone this repo via git:

```
$ git clone https://github.com/lijy91/biyi.git
```

2. Change to `biyi` directory

```
$ cd ~/lijy91/biyi
```

3. Install dependencies

```
$ melos bs
```

### Run app

```
$ cd apps/desktop
$ flutter run -d linux / macos / windows
```

## Discussion

> Welcome to join the discussion group to share your suggestions and ideas with me.

- [QQ Group](https://jq.qq.com/?_wv=1027&k=vYQ5jW7y)

## Related Links

- https://github.com/lijy91/biyi
- https://github.com/biyidev/uni_ocr
- https://github.com/biyidev/uni_translate
- https://github.com/leanflutter/hotkey_manager
- https://github.com/leanflutter/screen_text_extractor
- https://github.com/leanflutter/tray_manager
- https://github.com/libnativeapi/nativeapi

## License

[AGPL](./LICENSE)
