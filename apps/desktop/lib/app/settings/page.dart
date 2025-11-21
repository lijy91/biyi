import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/utils/utils.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:uikit/uikit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: Text(
                t.app.settings.text_version(
                  version: sharedEnv.appVersion,
                  buildNumber: '${sharedEnv.appBuildNumber}',
                ),
                style: Theme.of(context).typography.base,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(
          t.app.settings.title,
        ),
      ),
      child: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
