import 'package:flutter/material.dart';

import '../../includes.dart';

class LocalDbBuilder extends StatefulWidget {
  LocalDbBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  Widget Function(BuildContext context, DbData dbData) builder;

  @override
  _LocalDbBuilderState createState() => _LocalDbBuilderState();
}

class _LocalDbBuilderState extends State<LocalDbBuilder> {
  DbData get dbData => sharedLocalDb.dbData;

  @override
  void initState() {
    sharedLocalDb.addListener(_localDbListen);
    super.initState();
  }

  @override
  void dispose() {
    sharedLocalDb.removeListener(_localDbListen);
    super.dispose();
  }

  void _localDbListen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, dbData);
}
