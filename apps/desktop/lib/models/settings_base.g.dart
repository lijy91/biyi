// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, invalid_use_of_internal_member, unnecessary_non_null_assertion, unnecessary_null_comparison

part of 'settings_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoundShortcuts _$BoundShortcutsFromJson(Map<String, dynamic> json) =>
    BoundShortcuts(
      showOrHide: json['showOrHide'] == null
          ? null
          : HotKey.fromJson(json['showOrHide'] as Map<String, dynamic>),
      hide: json['hide'] == null
          ? null
          : HotKey.fromJson(json['hide'] as Map<String, dynamic>),
      extractFromScreenSelection: json['extractFromScreenSelection'] == null
          ? null
          : HotKey.fromJson(
              json['extractFromScreenSelection'] as Map<String, dynamic>),
      extractFromScreenCapture: json['extractFromScreenCapture'] == null
          ? null
          : HotKey.fromJson(
              json['extractFromScreenCapture'] as Map<String, dynamic>),
      extractFromClipboard: json['extractFromClipboard'] == null
          ? null
          : HotKey.fromJson(
              json['extractFromClipboard'] as Map<String, dynamic>),
      translateInputContent: json['translateInputContent'] == null
          ? null
          : HotKey.fromJson(
              json['translateInputContent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoundShortcutsToJson(BoundShortcuts instance) =>
    <String, dynamic>{
      'showOrHide': instance.showOrHide,
      'hide': instance.hide,
      'extractFromScreenSelection': instance.extractFromScreenSelection,
      'extractFromScreenCapture': instance.extractFromScreenCapture,
      'extractFromClipboard': instance.extractFromClipboard,
      'translateInputContent': instance.translateInputContent,
    };

SettingsBase _$SettingsBaseFromJson(Map<String, dynamic> json) => SettingsBase(
      defaultOcrEngineId: json['defaultOcrEngineId'] as String?,
      autoCopyRecognizedText: json['autoCopyRecognizedText'] as bool? ?? true,
      defaultTranslationEngineId: json['defaultTranslationEngineId'] as String?,
      translationMode: $enumDecodeNullable(
              _$TranslationModeEnumMap, json['translationMode']) ??
          TranslationMode.manual,
      defaultDetectLanguageEngineId:
          json['defaultDetectLanguageEngineId'] as String?,
      translationTargets: (json['translationTargets'] as List<dynamic>?)
          ?.map((e) => TranslationTarget.fromJson(e as Map<String, dynamic>))
          .toList(),
      doubleClickCopyResult: json['doubleClickCopyResult'] as bool? ?? true,
      inputSubmitMode: $enumDecodeNullable(
              _$InputSubmitModeEnumMap, json['inputSubmitMode']) ??
          InputSubmitMode.enter,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.light,
      trayIconEnabled: json['trayIconEnabled'] as bool? ?? true,
      maxWindowHeight: (json['maxWindowHeight'] as num?)?.toDouble() ?? 800,
      boundShortcuts: json['boundShortcuts'] == null
          ? null
          : BoundShortcuts.fromJson(
              json['boundShortcuts'] as Map<String, dynamic>),
      displayLanguage: json['displayLanguage'] as String?,
      autoStartEnabled: json['autoStartEnabled'] as bool? ?? false,
      ocrEngines: (json['ocrEngines'] as List<dynamic>?)
          ?.map((e) => OcrEngineConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      translationEngines: (json['translationEngines'] as List<dynamic>?)
          ?.map((e) =>
              TranslationEngineConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettingsBaseToJson(SettingsBase instance) =>
    <String, dynamic>{
      'defaultOcrEngineId': instance.defaultOcrEngineId,
      'autoCopyRecognizedText': instance.autoCopyRecognizedText,
      'defaultTranslationEngineId': instance.defaultTranslationEngineId,
      'translationMode': _$TranslationModeEnumMap[instance.translationMode]!,
      'defaultDetectLanguageEngineId': instance.defaultDetectLanguageEngineId,
      'translationTargets': instance.translationTargets,
      'doubleClickCopyResult': instance.doubleClickCopyResult,
      'inputSubmitMode': _$InputSubmitModeEnumMap[instance.inputSubmitMode]!,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'trayIconEnabled': instance.trayIconEnabled,
      'maxWindowHeight': instance.maxWindowHeight,
      'boundShortcuts': instance.boundShortcuts,
      'displayLanguage': instance.displayLanguage,
      'autoStartEnabled': instance.autoStartEnabled,
      'ocrEngines': instance.ocrEngines,
      'translationEngines': instance.translationEngines,
    };

const _$TranslationModeEnumMap = {
  TranslationMode.auto: 'auto',
  TranslationMode.manual: 'manual',
};

const _$InputSubmitModeEnumMap = {
  InputSubmitMode.enter: 'enter',
  InputSubmitMode.metaEnter: 'metaEnter',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
