import 'package:biyi_app/models/translation_result.dart';
import 'package:biyi_app/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:uikit/uikit.dart';

class TranslationResultView extends StatelessWidget {
  const TranslationResultView(
    this.translationResult, {
    super.key,
  });

  final TranslationResult translationResult;

  String get sourceLanguage =>
      translationResult.translationTarget!.sourceLanguage!;
  String get targetLanguage =>
      translationResult.translationTarget!.targetLanguage!;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LanguageLabel(
              sourceLanguage,
              flagSize: 18,
            ),
          ),
          SizedBox(
            width: 20,
            height: 38,
            child: Container(
              margin: EdgeInsets.zero,
              child: Icon(
                FluentIcons.arrow_right_20_regular,
                size: 16,
                color: themeData.colorScheme.foreground,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LanguageLabel(
              targetLanguage,
              flagSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
