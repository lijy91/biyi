// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/extension/hotkey.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/local_db/local_db.dart';
import 'package:biyi_app/states/actions/translate_input_content.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/utils/env.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/src/widgets/_window.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:window_manager/window_manager.dart';
import './features/mini_translator.dart';

Future<void> _ensureInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (UniPlatform.isLinux || UniPlatform.isMacOS || UniPlatform.isWindows) {
    await hotKeyManager.unregisterAll();
    await windowManager.ensureInitialized();
  }

  if (UniPlatform.isMacOS || UniPlatform.isWindows) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    LaunchAtStartup.instance.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );
    await protocolHandler.register('beyondtranslate');
  }

  await initEnv();
  // ignore: deprecated_member_use_from_same_package
  await initLocalDb();
  await Settings.instance.loadFromLocalFile();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await _ensureInitialized();

  // UniPlatform.call<Future<void>>(
  //   desktop: () async {
  //     const WindowOptions windowOptions = WindowOptions(
  //       alwaysOnTop: false,
  //       skipTaskbar: true,
  //       titleBarStyle: TitleBarStyle.hidden,
  //       windowButtonVisibility: false,
  //     );
  //     windowManager.waitUntilReadyToShow(windowOptions, () async {
  //       if (UniPlatform.isMacOS) {
  //         await windowManager.setVisibleOnAllWorkspaces(
  //           true,
  //           visibleOnFullScreen: true,
  //         );
  //       }
  //     });
  //   },
  //   otherwise: () => Future(() => null),
  // );

  runWidget(
    TranslationProvider(
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Settings.instance)],
        child: const ViewCollection(views: [MiniTranslatorApp(), MyApp()]),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _windowController = RegularWindowController(
    preferredSize: const Size(1280, 720),
    title: 'Beyond Translate',
  );

  @override
  void dispose() {
    _windowController.dispose();
    super.dispose();
  }

  final botToastBuilder = BotToastInit();

  Widget _buildApp(BuildContext context) {
    final settings = context.watch<Settings>();
    return RegularWindow(
      controller: _windowController,
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
                const DragToMoveArea(
                  child: SizedBox(width: double.infinity, height: 34),
                ),
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
