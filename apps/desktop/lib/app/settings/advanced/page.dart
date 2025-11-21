import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:uikit/uikit.dart';

class AdvancedSettingPage extends StatefulWidget {
  const AdvancedSettingPage({super.key});

  @override
  State<AdvancedSettingPage> createState() => _AdvancedSettingPageState();
}

class _AdvancedSettingPageState extends State<AdvancedSettingPage> {
  bool _launchAtLoginEnabled = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _launchAtLoginEnabled = await launchAtStartup.isEnabled();
    setState(() {});
  }

  Future<void> _handleLaunchAtLoginChanged(bool value) async {
    if (value) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
    _launchAtLoginEnabled = value;
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListSection(
          hasLeading: false,
          children: [
            SwitchListTile(
              value: _launchAtLoginEnabled,
              onChanged: _handleLaunchAtLoginChanged,
              title: Text(
                t.app.settings.advanced.launch_at_login.title,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(t.app.settings.advanced.title),
      ),
      child: _buildBody(context),
    );
  }
}
