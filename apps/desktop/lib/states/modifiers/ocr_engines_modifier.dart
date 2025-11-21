import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:collection/collection.dart';
import 'package:shortid/shortid.dart';

class OcrEnginesModifier {
  OcrEnginesModifier(
    this.settings, {
    required this.group,
    this.id,
  });

  final Settings settings;
  final String group;
  final String? id;

  List<OcrEngineConfig> list({
    bool Function(OcrEngineConfig element)? where,
  }) {
    if (where != null) {
      return settings.ocrEngines
          .where((e) => e.group == group)
          .where(where)
          .toList()
        ..sort((a, b) => a.position.compareTo(b.position));
    }
    return settings.ocrEngines.where((e) => e.group == group).toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }

  OcrEngineConfig? get() {
    return settings.ocrEngines.firstWhereOrNull((e) => e.id == id);
  }

  Future<void> create({
    required String type,
    required Map<String, dynamic> option,
  }) async {
    List<OcrEngineConfig> configs = list();
    int position = 1;
    if (configs.isNotEmpty) {
      position = configs.last.position + 1;
    }
    final config = OcrEngineConfig(
      position: position,
      group: group,
      id: id ?? shortid.generate(),
      type: type,
      option: option,
    );
    settings.ocrEngines.add(config);

    settings.notifyListeners();
  }

  Future<void> update({
    int? position,
    String? type,
    Map<String, dynamic>? option,
    bool? disabled,
  }) async {
    final index = settings.ocrEngines.indexWhere((element) => element.id == id);
    if (index == -1) return;

    final oldOcrEngine = settings.ocrEngines[index];
    settings.ocrEngines[index].position = position ?? oldOcrEngine.position;
    settings.ocrEngines[index].type = type ?? oldOcrEngine.type;
    settings.ocrEngines[index].option = option ?? oldOcrEngine.option;
    settings.ocrEngines[index].disabled = disabled ?? oldOcrEngine.disabled;

    settings.notifyListeners();
  }

  Future<void> delete() async {
    settings.ocrEngines.removeWhere((e) => e.id == id);

    settings.notifyListeners();
  }

  void deleteAll() {
    List<String> idList = list().map((e) => e.id).toList();
    settings.ocrEngines.removeWhere((e) => idList.contains(e.id));

    settings.notifyListeners();
  }

  bool exists() {
    OcrEngineConfig? config = get();
    return config != null && (config.group == group);
  }

  Future<void> updateOrCreate({
    String? type,
    Map<String, dynamic>? option,
    bool? disabled,
  }) async {
    if (id != null && exists()) {
      update(
        type: type,
        option: option,
        disabled: disabled,
      );
    } else {
      create(
        type: type!,
        option: option!,
      );
    }
  }
}
