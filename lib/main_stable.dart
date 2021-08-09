import 'package:flutter/material.dart';

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initEnv('stable');
  await initLocalDb();
  await initConfig();
  runApp(AppNavigator());
}
