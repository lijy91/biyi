import 'package:hotkey_manager/hotkey_manager.dart';

import '../../includes.dart';

abstract class ShortcutListener {
  void onShortcutKeyDownShowOrHide();
  void onShortcutKeyDownHide();
  void onShortcutKeyDownExtractFromScreenSelection();
  void onShortcutKeyDownExtractFromScreenCapture();
  void onShortcutKeyDownExtractFromClipboard();
  void onShortcutKeyDownSubmitWithMateEnter();
}

class ShortcutService {
  ShortcutService._();

  /// The shared instance of [ShortcutService].
  static final ShortcutService instance = ShortcutService._();

  ShortcutListener _listener;

  void setListener(ShortcutListener listener) {
    _listener = listener;
  }

  void start() async {
    await hotKeyManager.unregisterAll();
    await hotKeyManager.register(
      sharedConfig.shortcutInputSettingSubmitWithMetaEnter,
      keyDownHandler: (_) {
        _listener.onShortcutKeyDownSubmitWithMateEnter();
      },
    );
    await hotKeyManager.register(
      sharedConfig.shortcutShowOrHide,
      keyDownHandler: (_) {
        _listener.onShortcutKeyDownShowOrHide();
      },
    );
    await hotKeyManager.register(
      sharedConfig.shortcutHide,
      keyDownHandler: (_) {
        _listener.onShortcutKeyDownHide();
      },
    );
    await hotKeyManager.register(
      sharedConfig.shortcutExtractFromScreenSelection,
      keyDownHandler: (_) {
        _listener.onShortcutKeyDownExtractFromScreenSelection();
      },
    );
    if (!kIsLinux) {
      await hotKeyManager.register(
        sharedConfig.shortcutExtractFromScreenCapture,
        keyDownHandler: (_) {
          _listener.onShortcutKeyDownExtractFromScreenCapture();
        },
      );
    }
    await hotKeyManager.register(
      sharedConfig.shortcutExtractFromClipboard,
      keyDownHandler: (_) {
        _listener.onShortcutKeyDownExtractFromClipboard();
      },
    );
  }

  void stop() {
    hotKeyManager.unregisterAll();
  }
}
