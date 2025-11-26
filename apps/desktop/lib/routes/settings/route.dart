import 'dart:io';

import 'package:biyi_app/routes/settings/appearance/page.dart';
import 'package:biyi_app/routes/settings/language/page.dart';
import 'package:biyi_app/routes/settings/ocr_engines/page.dart';
import 'package:biyi_app/routes/settings/translation_engines/page.dart';
import 'package:flutter/material.dart' hide Card, Theme, Scaffold, Divider;
import 'package:go_router/go_router.dart';
import 'package:biyi_app/routes/settings/about/page.dart';
import 'package:biyi_app/routes/settings/advanced/page.dart';
import 'package:biyi_app/routes/settings/general/page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Colors, DialogRoute;
import 'package:biyi_app/routes/settings/keybinds/page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:biyi_app/i18n/strings.g.dart';

part 'route.g.dart';

@TypedShellRoute<SettingsShellRoute>(
  routes: [
    TypedGoRoute<KeybindsSettingsRoute>(
      path: '/settings/keybinds',
      name: 'KeybindsSettings',
    ),
    TypedGoRoute<LanguageSettingsRoute>(
      path: '/settings/language',
      name: 'LanguageSettings',
    ),
    TypedGoRoute<AppearanceSettingsRoute>(
      path: '/settings/appearance',
      name: 'AppearanceSettings',
    ),
    TypedGoRoute<GeneralSettingsRoute>(
      path: '/settings/general',
      name: 'GeneralSettings',
    ),
    TypedGoRoute<OcrEnginesSettingsRoute>(
      path: '/settings/ocr-engines',
      name: 'OcrEnginesSettings',
    ),
    TypedGoRoute<TranslationEnginesSettingsRoute>(
      path: '/settings/translation-engines',
      name: 'TranslationEnginesSettings',
    ),
    TypedGoRoute<AdvancedSettingsRoute>(
      path: '/settings/advanced',
      name: 'AdvancedSettings',
    ),
    TypedGoRoute<AboutSettingsRoute>(
      path: '/settings/about',
      name: 'AboutSettings',
    ),
  ],
)
class SettingsShellRoute extends ShellRouteData {
  const SettingsShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return SettingsLayout(child: navigator);
  }
}

class AppearanceSettingsRoute extends GoRouteData
    with $AppearanceSettingsRoute {
  const AppearanceSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppearanceSettingPage();
}

class GeneralSettingsRoute extends GoRouteData with $GeneralSettingsRoute {
  const GeneralSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GeneralSettingPage();
}

class KeybindsSettingsRoute extends GoRouteData with $KeybindsSettingsRoute {
  const KeybindsSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KeybindsSettingPage();
}

class LanguageSettingsRoute extends GoRouteData with $LanguageSettingsRoute {
  const LanguageSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LanguageSettingPage();
}

class AdvancedSettingsRoute extends GoRouteData with $AdvancedSettingsRoute {
  const AdvancedSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdvancedSettingPage();
}

class AboutSettingsRoute extends GoRouteData with $AboutSettingsRoute {
  const AboutSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutSettingPage();
}

class OcrEnginesSettingsRoute extends GoRouteData
    with $OcrEnginesSettingsRoute {
  const OcrEnginesSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OcrEnginesSettingPage();
}

class TranslationEnginesSettingsRoute extends GoRouteData
    with $TranslationEnginesSettingsRoute {
  const TranslationEnginesSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TranslationEnginesSettingPage();
}

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  String _getPageTitle(String path) {
    if (path.contains('/general')) return t.app.settings.general.title;
    if (path.contains('/appearance')) return t.app.settings.appearance.title;
    if (path.contains('/keybinds')) return t.app.settings.keybinds.title;
    if (path.contains('/language')) return t.app.settings.language.title;
    if (path.contains('/advanced')) return t.app.settings.advanced.title;
    if (path.contains('/ocr-engines')) return t.app.settings.ocr_engines.title;
    if (path.contains('/translation-engines')) {
      return t.app.settings.translation_engines.title;
    }
    if (path.contains('/about')) return t.app.settings.about.title;
    return 'Settings';
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    IconData icon,
    String path,
  ) {
    final theme = Theme.of(context);
    final isActive = GoRouterState.of(context).uri.path == path;

    return Container(
      decoration: isActive
          ? BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: GhostButton(
        onPressed: () => context.go(path),
        trailing: Icon(icon, size: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: isActive ? theme.typography.semiBold : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;
    final pageTitle = _getPageTitle(currentPath);

    return Scaffold(
      child: Row(
        children: [
          // Sidebar
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: theme.colorScheme.muted.withValues(alpha: 0.3),
              border: Border(
                right: BorderSide(
                  color: theme.colorScheme.border,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Platform.isMacOS ? 52 : 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      GhostButton(
                        density: ButtonDensity.icon,
                        onPressed: () => context.go('/'),
                        child: const Icon(
                          FluentIcons.arrow_left_20_regular,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Settings',
                        style: theme.typography.semiBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        t.app.settings.kLayout.navgroup.client,
                        style: theme.typography.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ).withPadding(horizontal: 12, vertical: 8),
                      _buildNavItem(
                        context,
                        t.app.settings.general.title,
                        FluentIcons.app_generic_20_regular,
                        '/settings/general',
                      ),
                      const SizedBox(height: 4),
                      _buildNavItem(
                        context,
                        t.app.settings.appearance.title,
                        FluentIcons.style_guide_20_regular,
                        '/settings/appearance',
                      ),
                      const SizedBox(height: 4),
                      _buildNavItem(
                        context,
                        t.app.settings.keybinds.title,
                        FluentIcons.keyboard_20_regular,
                        '/settings/keybinds',
                      ),
                      const SizedBox(height: 4),
                      _buildNavItem(
                        context,
                        t.app.settings.language.title,
                        FluentIcons.local_language_20_regular,
                        '/settings/language',
                      ),
                      const SizedBox(height: 4),
                      _buildNavItem(
                        context,
                        t.app.settings.advanced.title,
                        FluentIcons.settings_20_regular,
                        '/settings/advanced',
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.app.settings.kLayout.navgroup.integrations,
                        style: theme.typography.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ).withPadding(horizontal: 12, vertical: 8),
                      _buildNavItem(
                        context,
                        t.app.settings.ocr_engines.title,
                        FluentIcons.scan_20_regular,
                        '/settings/ocr-engines',
                      ),
                      const SizedBox(height: 4),
                      _buildNavItem(
                        context,
                        t.app.settings.translation_engines.title,
                        FluentIcons.translate_20_regular,
                        '/settings/translation-engines',
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.app.settings.kLayout.navgroup.resources,
                        style: theme.typography.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ).withPadding(horizontal: 12, vertical: 8),
                      _buildNavItem(
                        context,
                        t.app.settings.about.title,
                        FluentIcons.info_20_regular,
                        '/settings/about',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: Platform.isMacOS ? 56 : 24,
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.border,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    pageTitle,
                    style: theme.typography.h2,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsModalPage extends Page<void> {
  final Widget child;

  const SettingsModalPage({
    required this.child,
    super.key,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      context: context,
      settings: this,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1000,
            maxHeight: 700,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        ),
      ),
    );
  }
}
