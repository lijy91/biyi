import 'package:uni_translate/uni_translate.dart';

import '../includes.dart';

extension ExtWordPronunciation on WordPronunciation {
  String get localType {
    return R.string('common.pronunciation.${this.type}');
  }
}
