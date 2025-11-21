import 'package:biyi_app/models/translation_result_record.dart';
import 'package:biyi_app/models/translation_target.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_result.g.dart';

@JsonSerializable()
class TranslationResult {
  TranslationResult({
    this.id,
    this.translationTarget,
    this.translationResultRecordList,
    this.unsupportedEngineIdList,
  });

  factory TranslationResult.fromJson(Map<String, dynamic> json) =>
      _$TranslationResultFromJson(json);

  String? id;
  TranslationTarget? translationTarget;
  List<TranslationResultRecord>? translationResultRecordList;
  List<String>? unsupportedEngineIdList;

  Map<String, dynamic> toJson() => _$TranslationResultToJson(this);
}
