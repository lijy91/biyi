import 'package:uni_translate/uni_translate.dart';

import '../includes.dart';

extension ExtWordPronunciation on WordPronunciation {
  String get localType {
    return 'word_pronunciation.${this.type}'.tr();
  }
}
