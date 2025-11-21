// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'ocr_engine_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcrEngineConfig _$OcrEngineConfigFromJson(Map<String, dynamic> json) =>
    OcrEngineConfig(
      position: json['position'] as int? ?? -1,
      group: json['group'] as String?,
      id: json['id'] as String,
      type: json['type'] as String,
      option: json['option'] as Map<String, dynamic>,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$OcrEngineConfigToJson(OcrEngineConfig instance) =>
    <String, dynamic>{
      'position': instance.position,
      'group': instance.group,
      'id': instance.id,
      'type': instance.type,
      'option': instance.option,
      'disabled': instance.disabled,
    };
