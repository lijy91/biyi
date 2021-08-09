import './translation_result_record.dart';
import './translation_target.dart';

class TranslationResult {
  String id;
  TranslationTarget translationTarget;
  List<TranslationResultRecord> translationResultRecordList;

  TranslationResult({
    this.id,
    this.translationTarget,
    this.translationResultRecordList,
  });

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List<TranslationResultRecord> translationResultRecordList = [];

    if (json['translationResultRecordList'] != null) {
      translationResultRecordList =
          (json['translationResultRecordList'] as List)
              .map((item) => TranslationResultRecord.fromJson(item))
              .toList();
    }

    return TranslationResult(
      id: json['id'],
      translationTarget: TranslationTarget.fromJson(json['translationTarget']),
      translationResultRecordList: translationResultRecordList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'translationTarget': translationTarget,
      'translationResultRecordList':
          translationResultRecordList?.map((e) => e.toJson())?.toList(),
    };
  }
}
