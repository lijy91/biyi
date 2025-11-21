import 'package:biyi_app/i18n/strings.g.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

extension ExtWordPronunciation on WordPronunciation {
  String get localType {
    switch (type) {
      case 'us':
        return t.word_pronunciation.us;
      case 'uk':
        return t.word_pronunciation.uk;
    }
    return type ?? '';
  }
}
