import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:uikit/uikit.dart';

class AboutSettingPage extends StatefulWidget {
  const AboutSettingPage({super.key});

  @override
  State<AboutSettingPage> createState() => _AboutSettingPageState();
}

class _AboutSettingPageState extends State<AboutSettingPage> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {});
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: Text(
        t.app.settings.about.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListSection(
          hasLeading: false,
          children: [
            ListTile(
              title: Text(
                t.app.settings.about.package_info.version,
              ),
              additionalInfo: Text(_packageInfo?.version ?? 'Unknown'),
            ),
            ListTile(
              title: Text(
                t.app.settings.about.package_info.build_number,
              ),
              additionalInfo: Text(_packageInfo?.buildNumber ?? 'Unknown'),
            ),
          ],
        ),
      ],
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
