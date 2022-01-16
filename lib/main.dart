import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

import './includes.dart';

Future<void> _ensureInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AudioPlayer.ensureInitialized();
  if (kIsLinux || kIsMacOS || kIsWindows) {
    await WindowManager.instance.ensureInitialized();
  }

  if (kIsMacOS || kIsWindows) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    LaunchAtStartup.instance.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );
  }

  await ProAccount.instance.ensureInitialized();

  await initEnv();
  await initLocalDb();
  await initConfig();
}

void main() async {
  await _ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(kLanguageEN),
        // Locale(kLanguageJA),
        // Locale(kLanguageKO),
        // Locale(kLanguageRU),
        Locale(kLanguageZH),
      ],
      path: 'assets/translations',
      assetLoader: YamlAssetLoader(),
      fallbackLocale: const Locale(kLanguageEN),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    sharedConfigManager.addListener(_configListen);
    _init();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _themeMode = sharedConfig.themeMode;
    setState(() {});
  }

  void _init() async {
    _themeMode = sharedConfig.themeMode;
    setState(() {});
  }

  Widget _buildHome(BuildContext context) {
    if (kIsAndroid || kIsIOS) {
      return const HomePage();
    }
    return const DesktopPopupPage();
  }

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final botToastBuilder = BotToastInit();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: _themeMode,
      builder: (context, child) {
        if (kIsLinux || kIsWindows) {
          child = virtualWindowFrameBuilder(context, child);
        }
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: _buildHome(context),
    );
  }
}
