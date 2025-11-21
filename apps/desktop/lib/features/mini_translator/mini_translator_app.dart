// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uikit/uikit.dart';
import 'package:flutter/src/widgets/_window.dart';
import '../../i18n/strings.g.dart';
import './mini_translator.dart';

const _kMiniTranslatorTitle = 'Mini Translator';

class MiniTranslatorApp extends StatefulWidget {
  const MiniTranslatorApp({super.key});

  static const String title = _kMiniTranslatorTitle;

  @override
  State<MiniTranslatorApp> createState() => _MiniTranslatorAppState();
}

class _MiniTranslatorAppState extends State<MiniTranslatorApp> {
  final _windowController = RegularWindowController(
    preferredSize: const Size(380, 420),
    title: _kMiniTranslatorTitle,
  );

  @override
  void dispose() {
    _windowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegularWindow(
      controller: _windowController,
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
