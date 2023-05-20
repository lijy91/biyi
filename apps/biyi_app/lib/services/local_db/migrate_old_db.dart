import 'dart:convert';
import 'dart:io';

import 'package:biyi_app/includes.dart';
import 'package:shortid/shortid.dart';

class DbData {
  DbData({
    this.privateEngineList,
    this.privateOcrEngineList,
    this.preferenceList,
    this.translationTargetList,
  });

  factory DbData.fromJson(Map<String, dynamic> json) {
    List<TranslationEngineConfig> privateEngineList = [];
    List<OcrEngineConfig> privateOcrEngineList = [];
    List<UserPreference> preferenceList = [];
    List<TranslationTarget> translationTargetList = [];

    if (json['privateEngineList'] != null) {
      Iterable l = json['privateEngineList'] as List;
      privateEngineList =
          l.map((item) => TranslationEngineConfig.fromJson(item)).toList();
    }
    if (json['privateOcrEngineList'] != null) {
      Iterable l = json['privateOcrEngineList'] as List;
      privateOcrEngineList =
          l.map((item) => OcrEngineConfig.fromJson(item)).toList();
    }
    if (json['preferenceList'] != null) {
      Iterable l = json['preferenceList'] as List;
      preferenceList = l.map((item) => UserPreference.fromJson(item)).toList();
    }
    if (json['translationTargetList'] != null) {
      Iterable l = json['translationTargetList'] as List;
      translationTargetList =
          l.map((item) => TranslationTarget.fromJson(item)).toList();
    }

    return DbData(
      privateEngineList: privateEngineList,
      privateOcrEngineList: privateOcrEngineList,
      preferenceList: preferenceList,
      translationTargetList: translationTargetList,
    );
  }

  List<TranslationEngineConfig>? privateEngineList;
  List<OcrEngineConfig>? privateOcrEngineList;
  List<UserPreference>? preferenceList;
  List<TranslationTarget>? translationTargetList;

  List<TranslationEngineConfig> get engineList => [...?privateEngineList];
  List<OcrEngineConfig> get ocrEngineList => [...?privateOcrEngineList];

  Map<String, dynamic> toJson() {
    return {
      'privateEngineList':
          (privateEngineList ?? []).map((e) => e.toJson()).toList(),
      'privateOcrEngineList':
          (privateOcrEngineList ?? []).map((e) => e.toJson()).toList(),
      'preferenceList': (preferenceList ?? []).map((e) => e.toJson()).toList(),
      'translationTargetList':
          (translationTargetList ?? []).map((e) => e.toJson()).toList(),
    };
  }
}

Future<void> migrateOldDb() async {
  final appDir = await getAppDirectory();
  if (!appDir.existsSync()) {
    appDir.createSync(recursive: true);
  }
  final file = File('${appDir.path}/db.json');

  if (!file.existsSync()) {
    return;
  }
  String jsonString = await file.readAsString();
  DbData dbData = DbData.fromJson(json.decode(jsonString));

  for (TranslationEngineConfig e in dbData.privateEngineList ?? []) {
    await localDb //
        .privateEngine(e.identifier)
        .updateOrCreate(
          type: e.type,
          option: e.option,
          disabled: e.disabled,
        );
  }
  for (OcrEngineConfig e in dbData.privateOcrEngineList ?? []) {
    await localDb //
        .privateOcrEngine(e.identifier)
        .updateOrCreate(
          type: e.type,
          option: e.option,
          disabled: e.disabled,
        );
  }
  for (TranslationTarget e in dbData.translationTargetList ?? []) {
    await localDb //
        .translationTarget(e.id ?? shortid.generate())
        .updateOrCreate(
          sourceLanguage: e.sourceLanguage,
          targetLanguage: e.targetLanguage,
        );
  }
}
