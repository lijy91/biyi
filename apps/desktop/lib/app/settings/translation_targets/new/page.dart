import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/models/models.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';

class TranslationTargetNewOrEditPage extends StatefulWidget {
  const TranslationTargetNewOrEditPage({
    super.key,
    this.translationTarget,
  });

  final TranslationTarget? translationTarget;

  @override
  State<TranslationTargetNewOrEditPage> createState() =>
      _TranslationTargetNewOrEditPageState();
}

class _TranslationTargetNewOrEditPageState
    extends State<TranslationTargetNewOrEditPage> {
  String? _sourceLanguage;
  String? _targetLanguage;

  @override
  void initState() {
    if (widget.translationTarget != null) {
      _sourceLanguage = widget.translationTarget?.sourceLanguage;
      _targetLanguage = widget.translationTarget?.targetLanguage;
    }
    super.initState();
  }

  void _handleClickOk() {
    context.read<Settings>().transTargets.updateOrCreate(
          sourceLanguage: _sourceLanguage!,
          targetLanguage: _targetLanguage!,
        );
    Navigator.of(context).pop();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: Text(
        widget.translationTarget != null
            ? t.app.translation_targets.kNew.title_with_edit
            : t.app.translation_targets.kNew.title,
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
          children: [
            ListTile(
              title: Text(
                t.app.translation_targets.kNew.source_language,
              ),
              additionalInfo: _sourceLanguage != null
                  ? LanguageLabel(_sourceLanguage!)
                  : Text(t.please_choose),
              onTap: () async {
                final selectedLanguage = await context.push<String?>(
                  '${PageId.supportedLanguages}?selectedLanguage=$_sourceLanguage',
                );
                if (selectedLanguage != null) {
                  _sourceLanguage = selectedLanguage;
                  setState(() {});
                }
              },
            ),
            ListTile(
              title: Text(
                t.app.translation_targets.kNew.target_language,
              ),
              additionalInfo: _targetLanguage != null
                  ? LanguageLabel(_targetLanguage!)
                  : Text(t.please_choose),
              onTap: () async {
                final selectedLanguage = await context.push<String?>(
                  '${PageId.supportedLanguages}?selectedLanguage=$_targetLanguage',
                );
                if (selectedLanguage != null) {
                  _targetLanguage = selectedLanguage;
                  setState(() {});
                }
              },
            ),
          ],
        ),
        if (widget.translationTarget != null)
          ListSection(
            header: const Text(''),
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    t.delete,
                    // style: const TextStyle(color: Colors),
                  ),
                ),
                // accessoryView: Container(),
                onTap: () {
                  context
                      .read<Settings>()
                      .transTarget(widget.translationTarget!.id!)
                      .delete();
                  Navigator.of(context).pop();
                },
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
