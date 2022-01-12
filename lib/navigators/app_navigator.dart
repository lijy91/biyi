import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../includes.dart';

class AppNavigator extends StatefulWidget {
  final Widget home;

  const AppNavigator({
    Key key,
    this.home,
  }) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  Config _config = sharedConfigManager.getConfig();

  @override
  void initState() {
    sharedConfigManager.addListener(_configListen);
    if (widget.home == null) {
      R.setNavigatorKey(_navigatorKey);
    }
    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _config = sharedConfigManager.getConfig();
    setState(() {});
  }

  bool get isRootPage {
    return widget.home == null;
  }

  Widget _build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final botToastBuilder = BotToastInit();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: isRootPage ? _navigatorKey : null,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: _config.themeMode,
      builder: (context, child) {
        if (isRootPage) {
          if (kIsLinux || kIsWindows) {
            child = virtualWindowFrameBuilder(context, child);
          }
          child = botToastBuilder(context, child);
        }
        return child;
      },
      navigatorObservers: isRootPage ? [BotToastNavigatorObserver()] : [],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: isRootPage ? const DesktopPopupPage() : widget.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
