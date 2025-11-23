import 'dart:io';

import 'package:biyi_app/routes/settings/appearance/page.dart';
import 'package:biyi_app/routes/settings/language/page.dart';
import 'package:flutter/material.dart'
    hide Card, Theme, Scaffold, Divider, ThemeData, NavigationRail;
import 'package:go_router/go_router.dart';
import 'package:biyi_app/routes/settings/about/page.dart';
import 'package:biyi_app/routes/settings/advanced/page.dart';
import 'package:biyi_app/routes/settings/general/page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Colors, DialogRoute;
import 'package:biyi_app/routes/settings/keybinds/page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'package:biyi_app/i18n/strings.g.dart';
import 'package:uikit/uikit.dart' show PageScaffold;
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
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return SettingsModalPage(
      child: SettingsLayout(child: navigator),
    );
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

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  String? _selectedDestination = '/settings/general';
  final bool _expanded = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // UniPlatform.call<Future<void>>(
    //   desktop: () => _initWindow(),
    //   otherwise: () => Future(() => null),
    // );
  }

  @override
  void dispose() {
    // UniPlatform.call<Future<void>>(
    //   desktop: () => _uninitWindow(),
    //   otherwise: () => Future(() => null),
    // );
    super.dispose();
  }

  // @override
  // Future<void> onWindowClose() async {
  //   await windowManager.hide();
  //   // ignore: use_build_context_synchronously
  //   context.go(PageId.home);
  // }

  // Future<void> _initWindow() async {
  //   windowManager.addListener(this);
  //   const size = Size(840, 600);
  //   const minimunSize = Size(840, 600);
  //   const maximumSize = Size(840, 600);
  //   await Future.any([
  //     windowManager.setSize(size),
  //     windowManager.setMinimumSize(minimunSize),
  //     windowManager.setMaximumSize(maximumSize),
  //     windowManager.center(),
  //     windowManager.setSkipTaskbar(false),
  //     windowManager.setTitleBarStyle(
  //       TitleBarStyle.hidden,
  //       windowButtonVisibility: true,
  //     ),
  //     windowManager.setPreventClose(true),
  //   ]);

  //   await Future<void>.delayed(const Duration(milliseconds: 200));
  //   await windowManager.setOpacity(1);
  //   await windowManager.show();
  // }

  // Future<void> _uninitWindow() {
  //   windowManager.removeListener(this);
  //   return Future<void>.value();
  // }

  Future<void> _handleDestinationSelected(String value) async {
    setState(() {
      _selectedDestination = value;
    });
    context.go(value);
  }

  Widget _buildSidebar(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.muted,
        border: Border(
          right: BorderSide(
            color: themeData.colorScheme.border,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: Platform.isMacOS ? 32 : 6,
      ),
      width: 200,
      height: double.infinity,
      child: NavigationRail(
        backgroundColor: themeData.colorScheme.card,
        labelType: NavigationLabelType.expanded,
        labelPosition: NavigationLabelPosition.end,
        alignment: NavigationRailAlignment.start,
        expanded: _expanded,
        index: _selectedIndex,
        onSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });

          String newDestination = '/settings/general';
          switch (value) {
            case 0:
              newDestination = '/settings/general';
              break;
            case 1:
              newDestination = '/settings/appearance';
              break;
            case 2:
              newDestination = '/settings/keybinds';
              break;
            case 3:
              newDestination = '/settings/language';
              break;
            case 4:
              newDestination = '/settings/advanced';
              break;
            case 5:
              newDestination = '/settings/ocr-engines';
              break;
            case 6:
              newDestination = '/settings/translation-engines';
              break;
            case 7:
              newDestination = '/settings/about';
              break;
            default:
              newDestination = '/settings/general';
              break;
          }
          _handleDestinationSelected(newDestination);
        },
        children: [
          NavigationLabel(
            alignment: Alignment.centerLeft,
            child: Text(
              t.app.settings.kLayout.navgroup.client,
            ).semiBold().muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/general',
            label: Text(t.app.settings.general.title),
            child: const Icon(FluentIcons.app_generic_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsGeneral),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/appearance',
            label: Text(t.app.settings.appearance.title),
            child: const Icon(FluentIcons.style_guide_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsAppearance),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/keybinds',
            label: Text(t.app.settings.keybinds.title),
            child: const Icon(FluentIcons.keyboard_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsKeybinds),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/language',
            label: Text(t.app.settings.language.title),
            child: const Icon(FluentIcons.local_language_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsLanguage),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/advanced',
            label: Text(t.app.settings.advanced.title),
            child: const Icon(FluentIcons.settings_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsAdvanced),
          ),
          NavigationLabel(
            alignment: Alignment.centerLeft,
            child: Text(
              t.app.settings.kLayout.navgroup.integrations,
            ).semiBold().muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/ocr-engines',
            label: Text(t.app.settings.ocr_engines.title),
            child: const Icon(FluentIcons.scan_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsOcrEngines),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/translation-engines',
            label: Text(
              t.app.settings.translation_engines.title,
            ),
            child: const Icon(FluentIcons.translate_20_regular),
            // onTap: () => _handleDestinationSelected(
            //   PageId.settingsTranslationEngines,
            // ),
          ),
          NavigationLabel(
            alignment: Alignment.centerLeft,
            child: Text(
              t.app.settings.kLayout.navgroup.resources,
            ).semiBold().muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == '/settings/about',
            label: Text(t.app.settings.about.title),
            child: const Icon(FluentIcons.info_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsAbout),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = List<Widget>.generate(10, (int index) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: const Color.fromARGB(255, 255, 201, 197),
          height: 200,
        ),
      );
    });

    return PageScaffold(
      child: AdaptiveLayout(
        primaryNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.large: SlotLayout.from(
              key: const Key('primary-navigation-large'),
              builder: (_) => _buildSidebar(context),
            ),
          },
        ),
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('body-small'),
              builder: (_) => ListView.builder(
                itemCount: children.length,
                itemBuilder: (BuildContext context, int index) =>
                    children[index],
              ),
            ),
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('body-medium-and-up'),
              builder: (_) => ColoredBox(
                color: Theme.of(context).colorScheme.background,
                child: widget.child,
              ),
            ),
          },
        ),
        internalAnimations: false,
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
      barrierColor: Colors.black.withOpacity(0.35),
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
