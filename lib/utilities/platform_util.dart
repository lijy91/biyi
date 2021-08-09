import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

bool get kIsLinux => !kIsWeb && Platform.isLinux;
bool get kIsMacOS => !kIsWeb && Platform.isMacOS;
bool get kIsWindows => !kIsWeb && Platform.isWindows;

dynamic platformSelect({
  dynamic all,
  dynamic linux,
  dynamic macOS,
  dynamic windows,
}) {
  if (kIsLinux) return linux;
  if (kIsMacOS) return macOS;
  if (kIsWindows) return windows;
  return all;
}
