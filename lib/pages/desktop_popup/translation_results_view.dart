import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../includes.dart';

class TranslationResultsView extends StatelessWidget {
  final Key viewKey;
  final ScrollController controller;
  final String translationMode;
  final bool querySubmitted;
  final String text;
  final String textDetectedLanguage;
  final List<TranslationResult> translationResultList;
  final ValueChanged<String> onTextTapped;

  const TranslationResultsView({
    Key key,
    this.viewKey,
    this.controller,
    this.translationMode,
    this.querySubmitted,
    this.text,
    this.textDetectedLanguage,
    this.translationResultList,
    this.onTextTapped,
  }) : super(key: key);

  Widget _buildNoMatchingTranslationTarget(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
        bottom: 12,
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 40),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 12,
        ),
        child: Container(
          width: double.infinity,
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: '没有与'),
                TextSpan(
                  text: '${getLanguageName(textDetectedLanguage)}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                TextSpan(text: '匹配的翻译目标，'),
                TextSpan(text: '请添加该语种的翻译目标或切换至手动翻译模式。'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        controller: this.controller,
        child: Container(
          key: this.viewKey,
          width: viewWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (querySubmitted &&
                  translationMode == kTranslationModeAuto &&
                  translationResultList.isEmpty &&
                  textDetectedLanguage != null)
                _buildNoMatchingTranslationTarget(context),
              for (var result in this.translationResultList)
                Container(
                  width: viewWidth,
                  child: StickyHeader(
                    header: translationMode == kTranslationModeAuto
                        ? TranslationResultView(result)
                        : Container(),
                    content: Container(
                      child: Column(
                        children: [
                          for (var resultRecord
                              in result.translationResultRecordList ?? [])
                            TranslationResultRecordView(
                              translationResult: result,
                              translationResultRecord: resultRecord,
                              onTextTapped: onTextTapped,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
