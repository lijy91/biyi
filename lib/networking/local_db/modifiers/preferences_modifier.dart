import 'package:uuid/uuid.dart';

import '../../../includes.dart';

import '../local_db.dart';

class PreferencesModifier {
  final DbData dbData;

  PreferencesModifier(this.dbData);

  String? _key;

  void setKey(String? key) {
    _key = key;
  }

  List<UserPreference> get _preferenceList {
    if (dbData.preferenceList == null) {
      dbData.preferenceList = [];
    }
    return (dbData.preferenceList ?? []);
  }

  int get _preferenceIndex {
    return _preferenceList.indexWhere((e) => e.key == _key);
  }

  List<UserPreference> list() {
    return _preferenceList;
  }

  UserPreference? get() {
    if (_preferenceIndex == -1) return null;
    return _preferenceList[_preferenceIndex];
  }

  Future<void> create({
    required String key,
    String type = 'string',
    required String value,
  }) async {
    UserPreference userPreference = UserPreference(
      id: const Uuid().v4(),
      key: key,
      type: type,
      value: value,
    );
    _preferenceList.add(userPreference);
  }

  Future<void> update({
    String? type,
    String? value,
  }) async {
    if (type != null) _preferenceList[_preferenceIndex].type = type;
    if (value != null) _preferenceList[_preferenceIndex].value = value;
  }

  Future<void> delete() async {
    _preferenceList.removeAt(_preferenceIndex);
  }

  bool exists() {
    return _preferenceIndex != -1;
  }
}
