// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, invalid_use_of_internal_member, unnecessary_non_null_assertion, unnecessary_null_comparison

part of 'translation_result_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationResultRecord _$TranslationResultRecordFromJson(
        Map<String, dynamic> json) =>
    TranslationResultRecord(
      id: json['id'] as String?,
      translationTargetId: json['translationTargetId'] as String?,
      translationEngineId: json['translationEngineId'] as String?,
      lookUpRequest: json['lookUpRequest'] == null
          ? null
          : LookUpRequest.fromJson(
              json['lookUpRequest'] as Map<String, dynamic>),
      lookUpResponse: json['lookUpResponse'] == null
          ? null
          : LookUpResponse.fromJson(
              json['lookUpResponse'] as Map<String, dynamic>),
      translateRequest: json['translateRequest'] == null
          ? null
          : TranslateRequest.fromJson(
              json['translateRequest'] as Map<String, dynamic>),
      translateResponse: json['translateResponse'] == null
          ? null
          : TranslateResponse.fromJson(
              json['translateResponse'] as Map<String, dynamic>),
    )
      ..lookUpError = json['lookUpError'] == null
          ? null
          : UniTranslateClientError.fromJson(
              json['lookUpError'] as Map<String, dynamic>)
      ..translateError = json['translateError'] == null
          ? null
          : UniTranslateClientError.fromJson(
              json['translateError'] as Map<String, dynamic>);

Map<String, dynamic> _$TranslationResultRecordToJson(
        TranslationResultRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translationTargetId': instance.translationTargetId,
      'translationEngineId': instance.translationEngineId,
      'lookUpRequest': instance.lookUpRequest,
      'lookUpResponse': instance.lookUpResponse,
      'lookUpError': instance.lookUpError,
      'translateRequest': instance.translateRequest,
      'translateResponse': instance.translateResponse,
      'translateError': instance.translateError,
    };
