import 'package:flutter/material.dart';

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initEnv('beta');
  await initLocalDb();
  await initConfig();
  runApp(AppNavigator());
}
