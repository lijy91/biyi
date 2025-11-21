// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionPlatform _$VersionPlatformFromJson(Map<String, dynamic> json) =>
    VersionPlatform(
      platform: json['platform'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$VersionPlatformToJson(VersionPlatform instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'url': instance.url,
    };

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      version: json['version'] as String,
      buildNumber: json['buildNumber'] as int,
      platforms: (json['platforms'] as List<dynamic>)
          .map((e) => VersionPlatform.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'version': instance.version,
      'buildNumber': instance.buildNumber,
      'platforms': instance.platforms,
    };
