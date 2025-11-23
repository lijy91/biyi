import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';

extension on AppLocale {
  String get displayName {
    switch (this) {
      case AppLocale.en:
        return t.language.en;
      case AppLocale.zhCn:
        return t.language.zh_CN;
    }
  }
}

class LanguageSettingPage extends StatefulWidget {
  const LanguageSettingPage({super.key});

  @override
  State<LanguageSettingPage> createState() => _LanguageSettingPageState();
}

class _LanguageSettingPageState extends State<LanguageSettingPage> {
  late AppLocale _currentLocale;

  @override
  void initState() {
    _currentLocale = LocaleSettings.instance.currentLocale;
    super.initState();
  }

  void _handleUpdateSettings({
    AppLocale? locale,
  }) {
    final settings = context.read<Settings>();

    if (locale != null) {
      _currentLocale = locale;
      settings.update(
        displayLanguage: locale.languageTag,
      );
      LocaleSettings.instance.setLocale(locale);
    }
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListSection(
          hasLeading: false,
          children: [
            for (AppLocale locale in [AppLocale.en, AppLocale.zhCn])
              RadioListTile<AppLocale>(
                value: locale,
                groupValue: _currentLocale,
                onChanged: (_) async {
                  _handleUpdateSettings(locale: locale);
                },
                useCheckmarkStyle: true,
                title: Text(locale.displayName),
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
        title: Text(t.app.settings.language.title),
      ),
      child: _buildBody(context),
    );
  }
}
