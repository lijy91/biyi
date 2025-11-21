import 'package:biyi_app/utils/language_util.dart';
import 'package:biyi_app/widgets/language_flag_view/language_flag_view.dart';
import 'package:uikit/uikit.dart';

class LanguageLabel extends StatelessWidget {
  const LanguageLabel(
    this.language, {
    super.key,
    this.flagSize = 20,
    this.flagBorderColor,
    this.style,
  });

  final String language;
  final double flagSize;
  final Color? flagBorderColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GappedRow(
      gap: 6,
      mainAxisSize: MainAxisSize.min,
      children: [
        LanguageFlagView(
          language,
          size: flagSize,
          borderColor: flagBorderColor,
        ),
        Text(
          getLanguageName(language),
          style: style,
        ),
      ],
    );
  }
}
