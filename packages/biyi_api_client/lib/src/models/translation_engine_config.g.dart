// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'translation_engine_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationEngineConfig _$TranslationEngineConfigFromJson(
        Map<String, dynamic> json) =>
    TranslationEngineConfig(
      position: json['position'] as int? ?? -1,
      group: json['group'] as String?,
      id: json['id'] as String,
      type: json['type'] as String,
      supportedScopes: (json['supportedScopes'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$TranslationEngineScopeEnumMap, e))
              .toList() ??
          const [],
      option: json['option'] as Map<String, dynamic>,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$TranslationEngineConfigToJson(
        TranslationEngineConfig instance) =>
    <String, dynamic>{
      'position': instance.position,
      'group': instance.group,
      'id': instance.id,
      'type': instance.type,
      'supportedScopes': instance.supportedScopes
          .map((e) => _$TranslationEngineScopeEnumMap[e]!)
          .toList(),
      'option': instance.option,
      'disabled': instance.disabled,
    };

const _$TranslationEngineScopeEnumMap = {
  TranslationEngineScope.detectLanguage: 'detectLanguage',
  TranslationEngineScope.lookUp: 'lookUp',
  TranslationEngineScope.translate: 'translate',
};
