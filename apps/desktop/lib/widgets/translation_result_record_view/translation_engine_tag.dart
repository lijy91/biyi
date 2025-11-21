import 'package:biyi_app/models/ext_translation_engine_config.dart';
import 'package:biyi_app/models/translation_result_record.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/translation_engine_icon/translation_engine_icon.dart';
import 'package:uikit/uikit.dart';

class TranslationEngineTag extends StatefulWidget {
  const TranslationEngineTag({
    super.key,
    required this.translationResultRecord,
  });

  final TranslationResultRecord translationResultRecord;

  @override
  State<TranslationEngineTag> createState() => _TranslationEngineTagState();
}

class _TranslationEngineTagState extends State<TranslationEngineTag> {
  bool _isHovered = false;

  TranslationEngineConfig? get _translationEngineConfig {
    String id = widget.translationResultRecord.translationEngineId!;
    Settings settings = Settings.instance;
    return settings.proTranslationEngine(id).get() ??
        settings.privateTranslationEngine(id).get();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    if (_translationEngineConfig == null) {
      return const SizedBox();
    }
    return MouseRegion(
      onEnter: (event) {
        _isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        _isHovered = false;
        setState(() {});
      },
      child: Container(
        height: 40,
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.border,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 3,
            bottom: 3,
            left: 4,
            right: 2,
          ),
          child: Button.ghost(
            onPressed: () {},
            child: AnimatedCrossFade(
              crossFadeState: !_isHovered
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstCurve: Curves.ease,
              secondCurve: Curves.ease,
              sizeCurve: Curves.ease,
              firstChild: Row(
                children: [
                  TranslationEngineIcon(
                    _translationEngineConfig!.type,
                    size: 12,
                  ),
                ],
              ),
              secondChild: Row(
                children: [
                  TranslationEngineIcon(
                    _translationEngineConfig!.type,
                    size: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 2),
                    child: Text(
                      _translationEngineConfig!.typeName,
                      style: themeData.typography.small.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
