import 'package:biyi_app/models/translation_target.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:collection/collection.dart';
import 'package:shortid/shortid.dart';

class TranslationTargetsModifier {
  TranslationTargetsModifier(this.settings, {this.id});

  final Settings settings;
  final String? id;

  List<TranslationTarget> list() {
    return settings.translationTargets;
  }

  TranslationTarget? get() {
    return settings.translationTargets.firstWhereOrNull((e) => e.id == id);
  }

  Future<void> create({
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final value = TranslationTarget(
      id: id ?? shortid.generate(),
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
    settings.translationTargets.add(value);

    settings.notifyListeners();
  }

  Future<void> update({
    String? sourceLanguage,
    String? targetLanguage,
  }) async {
    final index = settings.translationTargets.indexWhere(
      (e) =>
          e.sourceLanguage == sourceLanguage &&
          e.targetLanguage == targetLanguage,
    );
    if (index == -1) return;
    settings.translationTargets[index].sourceLanguage = sourceLanguage;
    settings.translationTargets[index].targetLanguage = targetLanguage;

    settings.notifyListeners();
  }

  Future<void> delete() async {
    settings.translationTargets.removeWhere((e) => e.id == id);

    settings.notifyListeners();
  }

  bool exists() {
    return settings.translationTargets.any((e) => e.id == id);
  }

  Future<void> updateOrCreate({
    String? sourceLanguage,
    String? targetLanguage,
  }) async {
    if (id != null && exists()) {
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
