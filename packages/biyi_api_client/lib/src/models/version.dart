import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable()
class VersionPlatform {
  VersionPlatform({
    required this.platform,
    required this.url,
  });

  factory VersionPlatform.fromJson(Map<String, dynamic> json) =>
      _$VersionPlatformFromJson(json);

  final String platform;
  final String url;

  Map<String, dynamic> toJson() => _$VersionPlatformToJson(this);
}

@JsonSerializable()
class Version {
  Version({
    required this.version,
    required this.buildNumber,
    required this.platforms,
  });

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);

  final String version;
  final int buildNumber;
  final List<VersionPlatform> platforms;

  Map<String, dynamic> toJson() => _$VersionToJson(this);
}
