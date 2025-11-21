import 'package:uikit/uikit.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

const kWordImageSize = 74.0;

class WordImageView extends StatelessWidget {
  const WordImageView(
    this.wordImage, {
    super.key,
    this.onPressed,
  });

  final WordImage wordImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: kWordImageSize,
      height: kWordImageSize,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.border),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Button.primary(
        // padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Hero(
          tag: wordImage.url,
          child: Image.network(
            wordImage.url,
            width: kWordImageSize - 2,
            height: kWordImageSize - 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
