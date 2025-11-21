import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:collection/collection.dart';
import 'package:shortid/shortid.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class TranslationEnginesModifier {
  TranslationEnginesModifier(
    this.settings, {
    required this.group,
    this.id,
  });

  final Settings settings;
  final String group;
  final String? id;

  List<TranslationEngineConfig> list({
    bool Function(TranslationEngineConfig element)? where,
  }) {
    if (where != null) {
      return settings.translationEngines
          .where((e) => e.group == group)
          .where(where)
          .toList()
        ..sort((a, b) => a.position.compareTo(b.position));
    }
    return settings.translationEngines.where((e) => e.group == group).toList()
      ..sort((a, b) => a.position.compareTo(b.position));
  }

  TranslationEngineConfig? get() {
    return settings.translationEngines.firstWhereOrNull((e) => e.id == id);
  }

  Future<void> create({
    required String type,
    required Map<String, dynamic> option,
    List<String>? supportedScopes,
    bool? disabled,
  }) async {
    List<TranslationEngineConfig> configs = list();
    int position = 1;
    if (configs.isNotEmpty) {
      position = configs.last.position + 1;
    }
    final config = TranslationEngineConfig(
      position: position,
      group: group,
      id: id ?? shortid.generate(),
      type: type,
      option: option,
      supportedScopes: (supportedScopes ?? [])
          .map(
            (e) => TranslationEngineScope.values.firstWhere((v) => e == v.name),
          )
          .toList(),
      disabled: disabled ?? false,
    );
    settings.translationEngines.add(config);

    settings.notifyListeners();
  }

  Future<void> update({
    int? position,
    String? type,
    Map<String, dynamic>? option,
    List<String>? supportedScopes,
    bool? disabled,
  }) async {
    final index =
        settings.translationEngines.indexWhere((element) => element.id == id);
    if (index == -1) return;

    final oldTranslationEngine = settings.translationEngines[index];
    settings.translationEngines[index].position =
        position ?? oldTranslationEngine.position;
    settings.translationEngines[index].type = type ?? oldTranslationEngine.type;
    settings.translationEngines[index].option =
        option ?? oldTranslationEngine.option;
    if (supportedScopes != null) {
      settings.translationEngines[index].supportedScopes =
          TranslationEngineScope.values
              .where((e) => supportedScopes.contains(e.name))
              .toList();
    }
    settings.translationEngines[index].disabled =
        disabled ?? oldTranslationEngine.disabled;

    settings.notifyListeners();
  }

  void delete() {
    settings.translationEngines.removeWhere((e) => e.id == id);

    settings.notifyListeners();
  }

  void deleteAll() {
    List<String> idList = list().map((e) => e.id).toList();
    settings.translationEngines.removeWhere((e) => idList.contains(e.id));

    settings.notifyListeners();
  }

  bool exists() {
    TranslationEngineConfig? config = get();
    return config != null && (config.group == group);
  }

  void updateOrCreate({
    String? type,
    Map<String, dynamic>? option,
    List<String>? supportedScopes,
    bool? disabled,
  }) {
    if (id != null && exists()) {
      update(
        type: type,
        option: option,
        supportedScopes: supportedScopes,
        disabled: disabled,
      );
    } else {
      create(
        type: type!,
        option: option!,
        supportedScopes: supportedScopes,
        disabled: disabled,
      );
    }
  }
}
