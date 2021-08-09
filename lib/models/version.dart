class VersionPlatform {
  String platform;
  String url;

  VersionPlatform({
    this.platform,
    this.url,
  });

  factory VersionPlatform.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return VersionPlatform(
      platform: json['platform'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'url': url,
    };
  }
}

class Version {
  String version;
  int buildNumber;
  List<VersionPlatform> platforms;

  Version({
    this.version,
    this.buildNumber,
    this.platforms,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    List<VersionPlatform> platforms = [];

    if (json['platforms'] != null) {
      platforms = (json['platforms'] as List)
          .map((item) => VersionPlatform.fromJson(item))
          .toList();
    }
    return Version(
      version: json['version'],
      buildNumber: json['buildNumber'],
      platforms: platforms,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'buildNumber': buildNumber,
      'platforms': platforms.map((e) => e.toJson()).toList(),
    };
  }
}
