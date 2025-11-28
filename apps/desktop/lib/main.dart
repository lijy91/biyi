// ignore_for_file: invalid_use_of_internal_member, implementation_imports

// import 'dart:io';

import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/states/actions/translate_input_content.dart';
import 'package:biyi_app/states/settings.dart';
// import 'package:biyi_app/utils/env.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/src/widgets/_window.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nativeapi/nativeapi.dart';
// import 'package:hotkey_manager/hotkey_manager.dart';
// import 'package:launch_at_startup/launch_at_startup.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:protocol_handler/protocol_handler.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart' hide Image;
import 'package:uni_platform/uni_platform.dart';
import './features/mini_translator.dart';
import './router_config.dart';

import './extension/window_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  setupGlobalWillShowHook();
  setupGlobalWillHideHook();

  runWidget(
    TranslationProvider(
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Settings.instance)],
        child: const ViewCollection(views: [MiniTranslatorApp(), MainApp()]),
      ),
    ),
  );
}

// Future<void> _ensureInitialized() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (UniPlatform.isLinux || UniPlatform.isMacOS || UniPlatform.isWindows) {
//     await hotKeyManager.unregisterAll();
//     await windowManager.ensureInitialized();
//   }

//   if (UniPlatform.isMacOS || UniPlatform.isWindows) {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     LaunchAtStartup.instance.setup(
//       appName: packageInfo.appName,
//       appPath: Platform.resolvedExecutable,
//     );
//     await protocolHandler.register('beyondtranslate');
//   }

//   await initEnv();
//   await Settings.instance.loadFromLocalFile();
// }

const _kMainAppTitle = 'Beyond Translate';

final mainWindowController =
    RegularWindowController(
      preferredSize: const Size(1280, 720),
      title: _kMainAppTitle,
    )..setWillShowHook((window) {
      if (window.isFirstShow) {
        window.titleBarStyle = TitleBarStyle.hidden;
        window.center();
      }
      return true;
    });

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final TrayIcon _trayIcon;

  Window get _mainWindow => mainWindowController.window;

  Window get _miniTranslatorWindow => miniTranslatorWindowController.window;

  @override
  void initState() {
    super.initState();
    _setupTrayIcon();
  }

  void _setupTrayIcon() {
    _trayIcon = TrayIcon();
    final icon = Image.fromAsset('resources/images/tray_icon.png');
    if (icon != null) _trayIcon.icon = icon;
    _trayIcon.isVisible = true;
    _trayIcon.contextMenu = Menu()
      ..addItem(
        MenuItem('Open Settings')..on<MenuItemClickedEvent>((_) {
          _mainWindow.center();
          _mainWindow.show();
        }),
      )
      ..addItem(
        MenuItem('Exit')..on<MenuItemClickedEvent>((_) {
          print('Clicked Exit');
        }),
      );
    _trayIcon.contextMenuTrigger = ContextMenuTrigger.rightClicked;
    _trayIcon.on<TrayIconClickedEvent>((event) {
      final bounds = _trayIcon.bounds;
      if (bounds != null) {
        _miniTranslatorWindow.setPosition(
          bounds.left - (_miniTranslatorWindow.bounds.width - bounds.width) / 2,
          bounds.bottom + 10,
        );
      }
      _miniTranslatorWindow.show();
    });
  }

  Widget _buildApp(BuildContext context) {
    final botToastBuilder = BotToastInit();
    final settings = context.watch<Settings>();
    return RegularWindow(
      controller: mainWindowController,
      child: ShadcnApp.router(
        theme: const ThemeData(
          colorScheme: ColorSchemes.lightBlue,
          radius: 0.5,
        ),
        routerConfig: routerConfig,
        themeMode: settings.themeMode,
        builder: (context, child) {
          if (UniPlatform.isLinux || UniPlatform.isWindows) {
            child = Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                  child: child,
                ),
                // const DragToMoveArea(
                //   child: SizedBox(width: double.infinity, height: 34),
                // ),
              ],
            );
          }
          child = botToastBuilder(context, child);
          return child;
        },
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final boundShortcuts = Settings.instance.boundShortcuts;

    // final translateInputContentSingleActivator =
    //     boundShortcuts.translateInputContent.singleActivator;
    return Actions(
      actions: <Type, Action<Intent>>{
        TranslateInputContentIntent: TranslateInputContentAction(),
      },
      // child: GlobalShortcuts(
      //   shortcuts: {
      //     translateInputContentSingleActivator: TranslateInputContentIntent(),
      //   },
      //   child: _buildApp(context),
      // ),
      child: _buildApp(context),
    );
  }
}
