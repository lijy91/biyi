import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) 'utilities/dart_vlc_noop.dart' as vlc;

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  vlc.DartVLC.initialize();

  await initEnv('dev');
  await initLocalDb();
  await initConfig();
  runApp(AppNavigator());
}
