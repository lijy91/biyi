import 'package:uuid/uuid.dart';

import '../../../includes.dart';

import '../local_db.dart';

class ProOcrEnginesModifier {
  final DbData dbData;

  ProOcrEnginesModifier(this.dbData);

  String _id;

  void setId(String id) {
    _id = id;
  }

  List<OcrEngineConfig> get _ocrEngineList {
    if (dbData.proOcrEngineList == null) {
      dbData.proOcrEngineList = [];
    }
    return dbData.proOcrEngineList;
  }

  int get _ocrEngineIndex {
    return dbData.proOcrEngineList.indexWhere((e) => e.identifier == _id);
  }

  List<OcrEngineConfig> list({
    bool where(OcrEngineConfig element),
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
    String type,
    String name,
    Map<String, dynamic> option,
  }) async {
    OcrEngineConfig group = OcrEngineConfig(
      identifier: Uuid().v4(),
      type: type,
      name: name,
      option: option,
    );
    _ocrEngineList.add(group);
  }

  Future<void> update({
    bool disabled,
  }) async {
    if (disabled != null) _ocrEngineList[_ocrEngineIndex].disabled = disabled;
  }

  bool exists() {
    return _ocrEngineIndex != -1;
  }
}
