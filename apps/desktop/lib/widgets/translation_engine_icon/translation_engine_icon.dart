import 'package:biyi_app/utils/r.dart';
import 'package:uikit/uikit.dart';

class TranslationEngineIcon extends StatelessWidget {
  const TranslationEngineIcon(
    this.type, {
    super.key,
    this.size = 22,
    this.color,
    this.border,
  });

  final String type;
  final double size;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(R.image('translation_engine_icons/$type.png')),
          fit: BoxFit.cover,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color!,
                  BlendMode.color,
                )
              : null,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: border ??
            Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 0.5,
            ),
      ),
    );
  }
}
