import 'package:biyi_app/models/ext_translation_engine_config.dart';
import 'package:uikit/uikit.dart';

class TranslationEngineName extends StatelessWidget {
  const TranslationEngineName(
    this.translationEngineConfig, {
    super.key,
  });

  final TranslationEngineConfig translationEngineConfig;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Text.rich(
      TextSpan(
        text: translationEngineConfig.typeName,
        children: [
          TextSpan(
            text: ' (${translationEngineConfig.id})',
            style: themeData.typography.small.copyWith(
              color: Colors.neutral.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
