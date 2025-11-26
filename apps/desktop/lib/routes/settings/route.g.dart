// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element_parameter, require_trailing_commas, invalid_use_of_internal_member, unnecessary_non_null_assertion, unnecessary_null_comparison

part of 'route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$settingsShellRoute];

RouteBase get $settingsShellRoute => ShellRouteData.$route(
  navigatorKey: SettingsShellRoute.$navigatorKey,
  factory: $SettingsShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/settings/keybinds',
      name: 'KeybindsSettings',
      factory: $KeybindsSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/language',
      name: 'LanguageSettings',
      factory: $LanguageSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/appearance',
      name: 'AppearanceSettings',
      factory: $AppearanceSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/general',
      name: 'GeneralSettings',
      factory: $GeneralSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/ocr-engines',
      name: 'OcrEnginesSettings',
      factory: $OcrEnginesSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/translation-engines',
      name: 'TranslationEnginesSettings',
      factory: $TranslationEnginesSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/advanced',
      name: 'AdvancedSettings',
      factory: $AdvancedSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings/about',
      name: 'AboutSettings',
      factory: $AboutSettingsRoute._fromState,
    ),
  ],
);

extension $SettingsShellRouteExtension on SettingsShellRoute {
  static SettingsShellRoute _fromState(GoRouterState state) =>
      const SettingsShellRoute();
}

mixin $KeybindsSettingsRoute on GoRouteData {
  static KeybindsSettingsRoute _fromState(GoRouterState state) =>
      const KeybindsSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/keybinds');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LanguageSettingsRoute on GoRouteData {
  static LanguageSettingsRoute _fromState(GoRouterState state) =>
      const LanguageSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/language');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppearanceSettingsRoute on GoRouteData {
  static AppearanceSettingsRoute _fromState(GoRouterState state) =>
      const AppearanceSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/appearance');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GeneralSettingsRoute on GoRouteData {
  static GeneralSettingsRoute _fromState(GoRouterState state) =>
      const GeneralSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/general');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OcrEnginesSettingsRoute on GoRouteData {
  static OcrEnginesSettingsRoute _fromState(GoRouterState state) =>
      const OcrEnginesSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/ocr-engines');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TranslationEnginesSettingsRoute on GoRouteData {
  static TranslationEnginesSettingsRoute _fromState(GoRouterState state) =>
      const TranslationEnginesSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/translation-engines');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdvancedSettingsRoute on GoRouteData {
  static AdvancedSettingsRoute _fromState(GoRouterState state) =>
      const AdvancedSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/advanced');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AboutSettingsRoute on GoRouteData {
  static AboutSettingsRoute _fromState(GoRouterState state) =>
      const AboutSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/about');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
