import 'package:uuid/uuid.dart';

import '../../../includes.dart';

import '../local_db.dart';

class TranslationTargetsModifier {
  final DbData dbData;

  TranslationTargetsModifier(this.dbData);

  String? _id;

  void setId(String? id) {
    _id = id;
  }

  int get _translationTargetIndex {
    return (dbData.translationTargetList ?? []).indexWhere((e) => e.id == _id);
  }

  List<TranslationTarget> get _translationTargetList {
    if (dbData.translationTargetList == null) {
      dbData.translationTargetList = [];
    }
    return dbData.translationTargetList!;
  }

  List<TranslationTarget> list() {
    return _translationTargetList;
  }

  TranslationTarget get() {
    return _translationTargetList[_translationTargetIndex];
  }

  Future<void> create({
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    TranslationTarget group = TranslationTarget(
      id: Uuid().v4(),
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
    _translationTargetList.add(group);
  }

  Future<void> update({
    String? sourceLanguage,
    String? targetLanguage,
  }) async {
    if (sourceLanguage != null) this.get().sourceLanguage = sourceLanguage;
    if (targetLanguage != null) this.get().targetLanguage = targetLanguage;
  }

  Future<void> delete() async {
    _translationTargetList.removeAt(_translationTargetIndex);
  }

  bool exists() {
    return _translationTargetIndex != -1;
  }

  Future<void> updateOrCreate({
    String? sourceLanguage,
    String? targetLanguage,
  }) async {
    if (_id != null && exists()) {
      update(
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );
    } else {
      create(
        sourceLanguage: sourceLanguage!,
        targetLanguage: targetLanguage!,
      );
    }
  }
}
