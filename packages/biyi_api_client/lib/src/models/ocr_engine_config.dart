import 'package:json_annotation/json_annotation.dart';

part 'ocr_engine_config.g.dart';

@JsonSerializable()
class OcrEngineConfig {
  OcrEngineConfig({
    this.position = -1,
    this.group,
    required this.id,
    required this.type,
    required this.option,
    this.disabled = false,
  });

  factory OcrEngineConfig.fromJson(Map<String, dynamic> json) =>
      _$OcrEngineConfigFromJson({
        ...json,
        'id': json['id'] ?? json['identifier'],
        'option': Map<String, dynamic>.from(json['option'] ?? {}),
      });

  int position;
  String? group;
  final String id;
  String type;
  Map<String, dynamic> option;
  bool disabled = false;

  bool get isProGroup => group == 'pro';

  @Deprecated('No longer used')
  String get identifier => id;

  Map<String, dynamic> toJson() => _$OcrEngineConfigToJson(this);
}
