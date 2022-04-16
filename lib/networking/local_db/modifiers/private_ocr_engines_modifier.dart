import 'package:uuid/uuid.dart';

import '../../../includes.dart';

import '../local_db.dart';

class PrivateOcrEnginesModifier {
  final DbData dbData;

  PrivateOcrEnginesModifier(this.dbData);

  String? _id;

  void setId(String? id) {
    _id = id;
  }

  List<OcrEngineConfig> get _ocrEngineList {
    if (dbData.privateOcrEngineList == null) {
      dbData.privateOcrEngineList = [];
    }
    return dbData.privateOcrEngineList ?? [];
  }

  int get _ocrEngineIndex {
    return (dbData.privateOcrEngineList ?? [])
        .indexWhere((e) => e.identifier == _id);
  }

  List<OcrEngineConfig> list({
    bool where(OcrEngineConfig element)?,
  }) {
    if (where != null) {
      return _ocrEngineList.where(where).toList();
    }
    return _ocrEngineList;
  }

  OcrEngineConfig get() {
    return _ocrEngineList[_ocrEngineIndex];
  }

  Future<void> create({
    required String type,
    required String name,
    required Map<String, dynamic> option,
  }) async {
    OcrEngineConfig group = OcrEngineConfig(
      identifier: const Uuid().v4(),
      type: type,
      name: name,
      option: option,
    );
    _ocrEngineList.add(group);
  }

  Future<void> update({
    String? type,
    String? name,
    Map<String, dynamic>? option,
    bool? disabled,
  }) async {
    if (type != null) _ocrEngineList[_ocrEngineIndex].type = type;
    if (name != null) _ocrEngineList[_ocrEngineIndex].name = name;
    if (option != null) _ocrEngineList[_ocrEngineIndex].option = option;
    if (disabled != null) _ocrEngineList[_ocrEngineIndex].disabled = disabled;
  }

  Future<void> delete() async {
    _ocrEngineList.removeAt(_ocrEngineIndex);
  }

  bool exists() {
    return _ocrEngineIndex != -1;
  }

  Future<void> updateOrCreate({
    String? type,
    String? name,
    Map<String, dynamic>? option,
    bool? disabled,
  }) async {
    if (_id != null && exists()) {
      update(
        type: type,
        name: name,
        option: option,
        disabled: disabled,
      );
    } else {
      create(
        type: type!,
        name: name!,
        option: option!,
      );
    }
  }
}
