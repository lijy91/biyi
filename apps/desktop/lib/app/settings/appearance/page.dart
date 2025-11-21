import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';

const List<double> _kMaxWindowHeightOptions = [700, 800, 900, 1000];

class AppearanceSettingPage extends StatefulWidget {
  const AppearanceSettingPage({super.key});

  @override
  State<AppearanceSettingPage> createState() => _AppearanceSettingPageState();
}

class _AppearanceSettingPageState extends State<AppearanceSettingPage> {
  void _handleUpdateSettings({
    ThemeMode? themeMode,
    bool? trayIconEnabled,
    double? maxWindowHeight,
  }) {
    final settings = context.read<Settings>();
    settings.update(
      themeMode: themeMode,
      trayIconEnabled: trayIconEnabled,
      maxWindowHeight: maxWindowHeight,
    );
  }

  Widget _buildBody(BuildContext context) {
    final settings = context.watch<Settings>();
    return ListView(
      children: [
        ListSection(
          hasLeading: false,
          children: [
            for (var themeMode in [
              ThemeMode.light,
              ThemeMode.dark,
              ThemeMode.system,
            ])
              RadioListTile<ThemeMode>(
                value: themeMode,
                groupValue: settings.themeMode,
                onChanged: (value) => _handleUpdateSettings(themeMode: value),
                useCheckmarkStyle: true,
                title: Text(
                  themeMode == ThemeMode.light
                      ? t.theme_mode.light
                      : themeMode == ThemeMode.dark
                          ? t.theme_mode.dark
                          : t.theme_mode.system,
                ),
              ),
          ],
        ),
        ListSection(
          header: Text(
            t.app.settings.appearance.tray_icon.title,
          ),
          children: [
            SwitchListTile(
              value: settings.trayIconEnabled,
              onChanged: (newValue) =>
                  _handleUpdateSettings(trayIconEnabled: newValue),
              title: Text(
                t.app.settings.appearance.tray_icon.show.title,
              ),
            ),
          ],
        ),
        ListSection(
          hasLeading: false,
          header: Text(
            t.app.settings.appearance.max_window_height.title,
          ),
          children: [
            for (var option in _kMaxWindowHeightOptions)
              RadioListTile<double>(
                value: option,
                groupValue: settings.maxWindowHeight,
                onChanged: (value) =>
                    _handleUpdateSettings(maxWindowHeight: value),
                useCheckmarkStyle: true,
                title: Text('${option.toInt()}'),
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
        title: Text(t.app.settings.appearance.title),
      ),
      child: _buildBody(context),
    );
  }
}
