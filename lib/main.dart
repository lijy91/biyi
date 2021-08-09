import 'package:flutter/material.dart';
import 'package:network_inspector/network_inspector.dart';
// ignore: unused_import
import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) 'utilities/dart_vlc_noop.dart' as vlc;

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NetworkInspector(
    onRequest: (res) {
      print(prettyJsonString(res.toJson()));
    },
    onResponse: (req) {
      print(prettyJsonString(req.toJson()));
    },
  );

  vlc.DartVLC.initialize();

  await initEnv('dev');
  await initLocalDb();
  await initConfig();
  runApp(AppNavigator());
}
