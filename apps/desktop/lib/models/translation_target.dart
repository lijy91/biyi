import 'package:json_annotation/json_annotation.dart';

part 'translation_target.g.dart';

@JsonSerializable()
class TranslationTarget {
  TranslationTarget({
    this.id,
    this.sourceLanguage,
    this.targetLanguage,
  });

  factory TranslationTarget.fromJson(Map<String, dynamic> json) =>
      _$TranslationTargetFromJson(json);

  String? id;
  String? sourceLanguage;
  String? targetLanguage;

  Map<String, dynamic> toJson() => _$TranslationTargetToJson(this);
}
