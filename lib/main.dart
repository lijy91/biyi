import 'package:audio_player/audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  AudioPlayer.initialize();

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
