// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:biyi_app/extension/window_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uikit/uikit.dart';
import 'package:flutter/src/widgets/_window.dart';
import 'package:nativeapi/nativeapi.dart';
import '../../i18n/strings.g.dart';
import './mini_translator.dart';

const _kMiniTranslatorTitle = 'Mini Translator';

final miniTranslatorWindowController =
    RegularWindowController(
      preferredSize: const Size(380, 420),
      title: _kMiniTranslatorTitle,
    )..setWillShowHook((window) {
      if (window.isFirstShow) {
        window.titleBarStyle = TitleBarStyle.hidden;
        window.windowControlButtonsVisible = false;
        return false;
      }
      return true;
    });

class MiniTranslatorApp extends StatefulWidget {
  const MiniTranslatorApp({super.key});

  @override
  State<MiniTranslatorApp> createState() => _MiniTranslatorAppState();
}

class _MiniTranslatorAppState extends State<MiniTranslatorApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegularWindow(
      controller: miniTranslatorWindowController,
      child: ShadcnApp(
        debugShowCheckedModeBanner: false,
        title: _kMiniTranslatorTitle,
        home: const MiniTranslator(),
        theme: const ThemeData(
          colorScheme: ColorSchemes.lightBlue,
          radius: 0.5,
        ),
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}
