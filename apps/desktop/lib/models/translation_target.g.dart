// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, invalid_use_of_internal_member, unnecessary_non_null_assertion, unnecessary_null_comparison

part of 'translation_target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationTarget _$TranslationTargetFromJson(Map<String, dynamic> json) =>
    TranslationTarget(
      id: json['id'] as String?,
      sourceLanguage: json['sourceLanguage'] as String?,
      targetLanguage: json['targetLanguage'] as String?,
    );

Map<String, dynamic> _$TranslationTargetToJson(TranslationTarget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceLanguage': instance.sourceLanguage,
      'targetLanguage': instance.targetLanguage,
    };
