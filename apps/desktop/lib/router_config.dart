import 'package:go_router/go_router.dart';
import 'package:biyi_app/routes/route.dart';
import 'package:biyi_app/routes/settings/route.dart';

class PageId {
  static const String availableOcrEngines = '/available-ocr-engines';
  static const String availableTranslationEngines =
      '/available-translation-engines';
  static const String home = '/';
  static const String settingsOcrEnginesNew = '/settings/ocr-engines/new';
  static const String settingsGeneral = '/settings/general';
  static const String settingsAppearance = '/settings/appearance';
  static const String settingsKeybinds = '/settings/keybinds';
  static const String settingsLanguage = '/settings/language';
  static const String settingsAdvanced = '/settings/advanced';
  static const String settingsTranslationEngineTypes =
      '/settings/translation-engine-types';
  static const String settingsTranslationEngines =
      '/settings/translation-engines';
  static const String settingsOcrEngineTypes = '/settings/ocr-engine-types';
  static const String settingsOcrEngines = '/settings/ocr-engines';
  static const String settingsAbout = '/settings/about';
  static const String supportedLanguages = '/supported-languages';
  static const String settingsTranslationEnginesNew =
      '/settings/translation-engines/new';
  static const String translationTargetsNew =
      '/settings/translation-targets/new';
  static String settingsOcrEngine(String id) => '/settings/ocr-engines/$id';
  static String settingsTranslationEngine(String id) =>
      '/settings/translation-engines/$id';
  static String settingsTranslationTarget(String id) =>
      '/settings/translation-targets/$id';
}

final GoRouter routerConfig = GoRouter(
  routes: [
    $homeRoute,
    $settingsShellRoute,
  ],
);
