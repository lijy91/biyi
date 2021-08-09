import 'package:flutter/material.dart';

import '../includes.dart';

const kLanguageDE = 'de';
const kLanguageEN = 'en';
const kLanguageES = 'es';
const kLanguageFR = 'fr';
const kLanguageIT = 'it';
const kLanguageJA = 'ja';
const kLanguagePT = 'pt';
const kLanguageRU = 'ru';
const kLanguageZH = 'zh';

final List<String> kAppLanguages = [
  kLanguageEN,
  kLanguageZH,
];

final List<String> kSupportedLanguages = [
  kLanguageDE,
  kLanguageEN,
  kLanguageES,
  kLanguageFR,
  kLanguageIT,
  kLanguageJA,
  kLanguagePT,
  kLanguageRU,
  kLanguageZH,
];

final Map<String, String> _knownFlagIcons = {
  kLanguageDE: 'de',
  kLanguageEN: 'gb',
  kLanguageES: 'es',
  kLanguageFR: 'fr',
  kLanguageIT: 'in',
  kLanguageJA: 'jp',
  kLanguagePT: 'pt',
  kLanguageRU: 'ru',
  kLanguageZH: 'cn',
};

String getLanguageName(String language) {
  return R.string('common.language.${language.toLowerCase()}');
}

String getLanguageFlag(String language) {
  return R.image('flag_icons/${_knownFlagIcons[language]}.svg');
}

Locale languageToLocale(String language) {
  if (language.contains('-')) {
    return Locale(
        language.substring(0, 1).toUpperCase(), language.substring(1));
  }
  return Locale(language);
}
