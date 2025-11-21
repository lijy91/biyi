import 'package:flutter/widgets.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

extension HotKeyExt on HotKey {
  SingleActivator get singleActivator {
    final activator = SingleActivator(
      logicalKey,
      shift: (modifiers ?? []).contains(HotKeyModifier.shift),
      control: (modifiers ?? []).contains(HotKeyModifier.control),
      alt: (modifiers ?? []).contains(HotKeyModifier.alt),
      meta: (modifiers ?? []).contains(HotKeyModifier.meta),
    );
    return activator;
  }
}
