import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

part 'translation_engine_config.g.dart';

@JsonSerializable()
class TranslationEngineConfig {
  TranslationEngineConfig({
    this.position = -1,
    this.group,
    required this.id,
    required this.type,
    this.supportedScopes = const [],
    required this.option,
    this.disabled = false,
  });

  factory TranslationEngineConfig.fromJson(Map<String, dynamic> json) =>
      _$TranslationEngineConfigFromJson({
        ...json,
        'id': json['id'] ?? json['identifier'],
        'option': Map<String, dynamic>.from(json['option'] ?? {}),
      });

  int position;
  String? group;
  final String id;
  String type;
  List<TranslationEngineScope> supportedScopes;
  Map<String, dynamic> option;
  bool disabled = false;

  bool get isProGroup => group == 'pro';

  @Deprecated('No longer used')
  String get identifier => id;

  Map<String, dynamic> toJson() => _$TranslationEngineConfigToJson(this);
}
