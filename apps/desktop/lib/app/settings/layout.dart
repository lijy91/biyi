import 'dart:async';

import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:window_manager/window_manager.dart';

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> with WindowListener {
  String? _selectedDestination = PageId.settingsGeneral;
  bool _expanded = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    UniPlatform.call<Future<void>>(
      desktop: () => _initWindow(),
      otherwise: () => Future(() => null),
    );
  }

  @override
  void dispose() {
    UniPlatform.call<Future<void>>(
      desktop: () => _uninitWindow(),
      otherwise: () => Future(() => null),
    );
    super.dispose();
  }

  @override
  Future<void> onWindowClose() async {
    await windowManager.hide();
    // ignore: use_build_context_synchronously
    context.go(PageId.home);
  }

  Future<void> _initWindow() async {
    windowManager.addListener(this);
    const size = Size(840, 600);
    const minimunSize = Size(840, 600);
    const maximumSize = Size(840, 600);
    await Future.any([
      windowManager.setSize(size),
      windowManager.setMinimumSize(minimunSize),
      windowManager.setMaximumSize(maximumSize),
      windowManager.center(),
      windowManager.setSkipTaskbar(false),
      windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: true,
      ),
      windowManager.setPreventClose(true),
    ]);

    await Future<void>.delayed(const Duration(milliseconds: 200));
    await windowManager.setOpacity(1);
    await windowManager.show();
  }

  Future<void> _uninitWindow() {
    windowManager.removeListener(this);
    return Future<void>.value();
  }

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
        top: !UniPlatform.isWeb && UniPlatform.isMacOS ? 32 : 6,
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

          String newDestination = PageId.settingsGeneral;
          switch (value) {
            case 0:
              newDestination = PageId.settingsGeneral;
              break;
            case 1:
              newDestination = PageId.settingsAppearance;
              break;
            case 2:
              newDestination = PageId.settingsKeybinds;
              break;
            case 3:
              newDestination = PageId.settingsLanguage;
              break;
            case 4:
              newDestination = PageId.settingsAdvanced;
              break;
            case 5:
              newDestination = PageId.settingsOcrEngines;
              break;
            case 6:
              newDestination = PageId.settingsTranslationEngines;
              break;
            case 7:
              newDestination = PageId.settingsAbout;
              break;
            default:
              newDestination = PageId.settingsGeneral;
              break;
          }
          _handleDestinationSelected(newDestination);
        },
        children: [
          NavigationLabel(
            alignment: Alignment.centerLeft,
            child:
                Text(t.app.settings.kLayout.navgroup.client).semiBold().muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsGeneral,
            label: Text(t.app.settings.general.title),
            child: const Icon(FluentIcons.app_generic_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsGeneral),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsAppearance,
            label: Text(t.app.settings.appearance.title),
            child: const Icon(FluentIcons.style_guide_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsAppearance),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsKeybinds,
            label: Text(t.app.settings.keybinds.title),
            child: const Icon(FluentIcons.keyboard_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsKeybinds),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsLanguage,
            label: Text(t.app.settings.language.title),
            child: const Icon(FluentIcons.local_language_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsLanguage),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsAdvanced,
            label: Text(t.app.settings.advanced.title),
            child: const Icon(FluentIcons.settings_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsAdvanced),
          ),
          NavigationLabel(
            alignment: Alignment.centerLeft,
            child: Text(t.app.settings.kLayout.navgroup.integrations)
                .semiBold()
                .muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsOcrEngines,
            label: Text(t.app.settings.ocr_engines.title),
            child: const Icon(FluentIcons.scan_20_regular),
            // onTap: () => _handleDestinationSelected(PageId.settingsOcrEngines),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsTranslationEngines,
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
            child: Text(t.app.settings.kLayout.navgroup.resources)
                .semiBold()
                .muted(),
          ),
          NavigationItem(
            alignment: Alignment.centerLeft,
            selected: _selectedDestination == PageId.settingsAbout,
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
