import 'dart:ui';

import 'package:biyi_app/utils/language_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('languageToLocale', () {
    Locale locale = languageToLocale('en-US');
    expect(locale.languageCode, 'en');
    expect(locale.countryCode, 'US');
    expect(locale, const Locale('en', 'US'));
  });
}
