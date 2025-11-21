import 'dart:ui' as ui;

import 'package:biyi_app/models/models.dart';
import 'package:biyi_app/models/settings_base.dart';
import 'package:biyi_app/utils/language_util.dart';
import 'package:biyi_app/widgets/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:sticky_headers/sticky_headers.dart';

class TranslationResultsView extends StatelessWidget {
  const TranslationResultsView({
    super.key,
    required this.viewKey,
    required this.controller,
    required this.translationMode,
    required this.querySubmitted,
    required this.text,
    required this.textDetectedLanguage,
    required this.translationResultList,
    required this.onTextTapped,
    required this.doubleClickCopyResult,
  });

  final Key viewKey;
  final ScrollController controller;
  final TranslationMode translationMode;
  final bool querySubmitted;
  final String text;
  final String? textDetectedLanguage;
  final List<TranslationResult> translationResultList;
  final ValueChanged<String> onTextTapped;
  final bool doubleClickCopyResult;

  Widget _buildNoMatchingTranslationTarget(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      // margin: const EdgeInsets.only(
      //   left: 12,
      //   right: 12,
      //   top: 0,
      //   bottom: 12,
      // ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 12,
        ),
        width: double.infinity,
        child: SelectableText.rich(
          TextSpan(
            children: [
              const TextSpan(text: '没有与'),
              TextSpan(
                text: getLanguageName(textDetectedLanguage!),
                style: TextStyle(color: themeData.colorScheme.primary),
              ),
              const TextSpan(text: '匹配的翻译目标，'),
              const TextSpan(text: '请添加该语种的翻译目标或切换至手动翻译模式。'),
            ],
          ),
          selectionHeightStyle: ui.BoxHeightStyle.max,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        controller: controller,
        child: SizedBox(
          key: viewKey,
          width: viewWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (querySubmitted &&
                  translationMode == TranslationMode.auto &&
                  translationResultList.isEmpty &&
                  textDetectedLanguage != null)
                _buildNoMatchingTranslationTarget(context),
              for (var result in translationResultList)
                SizedBox(
                  width: viewWidth,
                  child: StickyHeader(
                    header: translationMode == TranslationMode.auto
                        ? TranslationResultView(result)
                        : Container(),
                    content: Column(
                      children: [
                        if (translationMode == TranslationMode.auto)
                          const SizedBox(height: 12),
                        for (var resultRecord
                            in result.translationResultRecordList ?? [])
                          TranslationResultRecordView(
                            translationResult: result,
                            translationResultRecord: resultRecord,
                            onTextTapped: onTextTapped,
                            doubleClickCopyResult: doubleClickCopyResult,
                          ),
                      ],
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
