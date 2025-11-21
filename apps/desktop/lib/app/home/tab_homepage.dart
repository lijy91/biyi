import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class TabHomepageScene extends StatefulWidget {
  const TabHomepageScene({super.key});

  @override
  State<StatefulWidget> createState() => _TabHomepageSceneState();
}

class _TabHomepageSceneState extends State<TabHomepageScene> {
  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Button.primary(
          onPressed: () {
            context.go(PageId.settingsGeneral);
          },
          child: const Text('settings/general'),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const CustomizedAppBar(
      title: Text('比译'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: _buildAppBar(context),
      child: _buildBody(context),
    );
  }
}
