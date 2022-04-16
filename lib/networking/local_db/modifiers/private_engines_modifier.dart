import 'package:uuid/uuid.dart';

import '../../../includes.dart';

import '../local_db.dart';

class PrivateEnginesModifier {
  final DbData dbData;

  PrivateEnginesModifier(this.dbData);

  String? _id;

  void setId(String? id) {
    _id = id;
  }

  int get _engineIndex {
    return (dbData.privateEngineList ?? [])
        .indexWhere((e) => e.identifier == _id);
  }

  List<TranslationEngineConfig> get _engineList {
    return dbData.privateEngineList ?? [];
  }

  List<TranslationEngineConfig> list({
    bool where(TranslationEngineConfig element)?,
  }) {
    if (where != null) {
      return _engineList.where(where).toList();
    }
    return _engineList;
  }

  TranslationEngineConfig? get() {
    if (exists()) {
      return _engineList[_engineIndex];
    }
    return null;
  }

  Future<void> create({
    required String type,
    required String name,
    required Map<String, dynamic> option,
    required List<String> disabledScopes,
  }) async {
    TranslationEngineConfig engineConfig = TranslationEngineConfig(
      identifier: const Uuid().v4(),
      type: type,
      name: name,
      option: option,
      disabledScopes: disabledScopes,
    );
    _engineList.add(engineConfig);
  }

  Future<void> update({
    String? type,
    String? name,
    Map<String, dynamic>? option,
    List<String>? disabledScopes,
    bool? disabled,
  }) async {
    if (type != null) _engineList[_engineIndex].type = type;
    if (name != null) _engineList[_engineIndex].name = name;
    if (option != null) _engineList[_engineIndex].option = option;
    if (disabledScopes != null)
      _engineList[_engineIndex].disabledScopes = disabledScopes;
    if (disabled != null) _engineList[_engineIndex].disabled = disabled;
  }

  Future<void> delete() async {
    _engineList.removeAt(_engineIndex);
  }

  bool exists() {
    return _engineIndex != -1;
  }

  Future<void> updateOrCreate({
    String? type,
    String? name,
    Map<String, dynamic>? option,
    List<String>? disabledScopes,
    bool? disabled,
  }) async {
    if (_id != null && exists()) {
      update(
        type: type,
        name: name,
        option: option,
        disabledScopes: disabledScopes,
        disabled: disabled,
      );
    } else {
      create(
        type: type!,
        name: name!,
        option: option!,
        disabledScopes: disabledScopes!,
      );
    }
  }
}
