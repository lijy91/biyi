import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/utils/language_util.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/language_label/language_label.dart';

import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class SupportedLanguagesPage extends StatefulWidget {
  const SupportedLanguagesPage({
    super.key,
    this.selectedLanguage,
  });

  final String? selectedLanguage;

  @override
  State<StatefulWidget> createState() => _SupportedLanguagesPageState();
}

class _SupportedLanguagesPageState extends State<SupportedLanguagesPage> {
  String? _selectedLanguage;

  @override
  void initState() {
    _selectedLanguage = widget.selectedLanguage;
    super.initState();
  }

  void _handleClickOk() {
    context.pop<String?>(_selectedLanguage);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: Text(
        t.app.supported_languages.title,
      ),
      actions: [
        Button.primary(
          onPressed: _handleClickOk,
          child: Text(t.ok),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListSection(
          header: Text(
            t.app.supported_languages.all.title,
          ),
          children: [
            for (var supportedLanguage in kSupportedLanguages)
              RadioListTile<String>(
                value: supportedLanguage,
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  _selectedLanguage = value;
                  setState(() {});
                },
                useCheckmarkStyle: true,
                title: LanguageLabel(supportedLanguage),
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
