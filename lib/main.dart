import 'dart:io';

import 'package:anyinspect/anyinspect.dart';
import 'package:anyinspect_plugin_network/anyinspect_plugin_network.dart';
import 'package:anyinspect_plugin_shared_preferences/anyinspect_plugin_shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

import './includes.dart';

void main() async {
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

  await initEnv('dev');
  await initLocalDb();
  await initConfig();

  if (!kReleaseMode) {
    AnyInspect anyInspect = AnyInspect.instance;
    anyInspect.addPlugin(AnyInspectPluginNetwork());
    anyInspect.addPlugin(AnyInspectPluginSharedPreferences());
    anyInspect.start();
  }

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(kLanguageEN),
        // Locale(kLanguageJA),
        // Locale(kLanguageKO),
        // Locale(kLanguageRU),
        Locale(kLanguageZH),
      ],
      path: 'assets/translations',
      assetLoader: YamlAssetLoader(),
      fallbackLocale: Locale(kLanguageEN),
      child: AppNavigator(),
    ),
  );
}
