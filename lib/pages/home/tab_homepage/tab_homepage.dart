import 'package:flutter/material.dart';

import '../../../includes.dart';

class TabHomepageScene extends StatelessWidget {
  const TabHomepageScene({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Home'),
      ),
      body: Container(),
    );
  }
}
