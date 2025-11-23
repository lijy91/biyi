import 'package:go_router/go_router.dart';
import 'package:biyi_app/routes/route.dart';
import 'package:biyi_app/routes/settings/route.dart';

final GoRouter routerConfig = GoRouter(
  routes: [
    $homeRoute,
    $settingsShellRoute,
  ],
);
