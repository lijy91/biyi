import '../../../includes.dart';

import '../local_db.dart';

class ProEnginesModifier {
  final DbData dbData;

  ProEnginesModifier(this.dbData);

  String _id;

  void setId(String id) {
    _id = id;
  }

  int get _engineIndex {
    return dbData.proEngineList.indexWhere((e) => e.identifier == _id);
  }

  List<TranslationEngineConfig> get _engineList {
    return dbData.proEngineList;
  }

  List<TranslationEngineConfig> list({
    bool where(TranslationEngineConfig element),
  }) {
    if (where != null) {
      return _engineList.where(where).toList();
    }
    return _engineList;
  }

  TranslationEngineConfig get() {
    if (exists()) {
      return _engineList[_engineIndex];
    }
    return null;
  }

  Future<void> update({
    bool disabled,
  }) async {
    if (disabled != null) _engineList[_engineIndex].disabled = disabled;
  }

  bool exists() {
    return _engineIndex != -1;
  }
}
