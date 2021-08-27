import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) 'utilities/dart_vlc_noop.dart' as vlc;

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  vlc.DartVLC.initialize();

  await initEnv('dev');
  await initLocalDb();
  await initConfig();
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
