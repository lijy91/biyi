import 'package:flutter/material.dart';

import '../../includes.dart';

class ModalBottomSheetWrapped extends StatefulWidget {
  final Widget child;

  const ModalBottomSheetWrapped({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _ModalBottomSheetWrappedState createState() =>
      _ModalBottomSheetWrappedState();
}

class _ModalBottomSheetWrappedState extends State<ModalBottomSheetWrapped> {
  Config _config = sharedConfigManager.getConfig();

  @override
  void initState() {
    sharedConfigManager.addListener(_configListen);
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

  Widget _build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: _config.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: _build(context),
    );
  }
}
