import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

part 'translation_result_record.g.dart';

@JsonSerializable()
class TranslationResultRecord {
  TranslationResultRecord({
    this.id,
    this.translationTargetId,
    this.translationEngineId,
    this.lookUpRequest,
    this.lookUpResponse,
    this.translateRequest,
    this.translateResponse,
  });

  factory TranslationResultRecord.fromJson(Map<String, dynamic> json) =>
      _$TranslationResultRecordFromJson(json);

  String? id;
  String? translationTargetId;
  String? translationEngineId;
  LookUpRequest? lookUpRequest;
  LookUpResponse? lookUpResponse;
  UniTranslateClientError? lookUpError;
  TranslateRequest? translateRequest;
  TranslateResponse? translateResponse;
  UniTranslateClientError? translateError;

  Map<String, dynamic> toJson() => _$TranslationResultRecordToJson(this);
}
