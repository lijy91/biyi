import 'package:flutter/cupertino.dart';
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
      title: widget.translationTarget != null ? Text('修改翻译目标') : Text('添加翻译目标'),
      actions: [
        CustomAppBarActionItem(
          text: '保存',
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
                title: Text('源语言'),
                detailText: _sourceLanguage != null
                    ? LanguageLabel(_sourceLanguage)
                    : Text('请选择'),
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
                title: Text('目标语言'),
                detailText: _targetLanguage != null
                    ? LanguageLabel(_targetLanguage)
                    : Text('请选择'),
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
                      '删除',
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
