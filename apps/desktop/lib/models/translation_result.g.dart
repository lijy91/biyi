// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, invalid_use_of_internal_member, unnecessary_non_null_assertion, unnecessary_null_comparison

part of 'translation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationResult _$TranslationResultFromJson(Map<String, dynamic> json) =>
    TranslationResult(
      id: json['id'] as String?,
      translationTarget: json['translationTarget'] == null
          ? null
          : TranslationTarget.fromJson(
              json['translationTarget'] as Map<String, dynamic>),
      translationResultRecordList:
          (json['translationResultRecordList'] as List<dynamic>?)
              ?.map((e) =>
                  TranslationResultRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
      unsupportedEngineIdList:
          (json['unsupportedEngineIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$TranslationResultToJson(TranslationResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translationTarget': instance.translationTarget,
      'translationResultRecordList': instance.translationResultRecordList,
      'unsupportedEngineIdList': instance.unsupportedEngineIdList,
    };
