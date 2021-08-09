import 'package:flutter/material.dart';
import 'package:yaml_localizations/yaml_localizations.dart';

class R {
  static GlobalKey<NavigatorState> _navigatorKey;

  static setNavigatorKey(GlobalKey navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  static GlobalKey<NavigatorState> getNavigatorKey() {
    return _navigatorKey;
  }

  static String string(String key) {
    try {
      return YamlLocalizations.of(_navigatorKey.currentContext).string(key);
    } catch (error) {
      return key;
    }
  }

  static String image(String name) {
    return 'assets/images/$name';
  }
}
