import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationTargetNewPage extends StatefulWidget {
  final TranslationTarget translationTarget;

  const TranslationTargetNewPage({
    Key key,
    this.translationTarget,
  }) : super(key: key);

  @override
  _TranslationTargetNewPageState createState() =>
      _TranslationTargetNewPageState();
}

class _TranslationTargetNewPageState extends State<TranslationTargetNewPage> {
  String _sourceLanguage;
  String _targetLanguage;

  String t(String key, {List<String> args}) {
    return 'page_translation_target_new.$key'.tr(args: args);
  }

  @override
  void initState() {
    if (widget.translationTarget != null) {
      _sourceLanguage = widget.translationTarget.sourceLanguage;
      _targetLanguage = widget.translationTarget.targetLanguage;
    }
    super.initState();
  }

  void _handleClickOk() async {
    await sharedLocalDb
        .translationTarget(widget.translationTarget?.id)
        .updateOrCreate(
          sourceLanguage: _sourceLanguage,
          targetLanguage: _targetLanguage,
        );
    await sharedLocalDb.write();

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: widget.translationTarget != null
          ? Text(t('title_with_edit'))
          : Text(t('title')),
      actions: [
        CustomAppBarActionItem(
          text: 'ok'.tr(),
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: Text(t('source_language')),
                detailText: _sourceLanguage != null
                    ? LanguageLabel(_sourceLanguage)
                    : Text('please_choose'.tr()),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LanguageChooserPage(
                        onChoosed: (language) {
                          _sourceLanguage = language;
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
              PreferenceListItem(
                title: Text(t('target_language')),
                detailText: _targetLanguage != null
                    ? LanguageLabel(_targetLanguage)
                    : Text('please_choose'.tr()),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LanguageChooserPage(
                        onChoosed: (language) {
                          _targetLanguage = language;
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          if (widget.translationTarget != null)
            PreferenceListSection(
              title: Text(''),
              children: [
                PreferenceListItem(
                  title: Center(
                    child: Text(
                      'delete'.tr(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  accessoryView: Container(),
                  onTap: () async {
                    await sharedLocalDb
                        .translationTarget(widget.translationTarget.id)
                        .delete();
                    await sharedLocalDb.write();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
