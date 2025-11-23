import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:biyi_app/routes/home/page.dart';

part 'route.g.dart';

@TypedGoRoute<HomeRoute>(path: '/', name: 'Home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
