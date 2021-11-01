import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

const kAppBuildNumber = '6';

Future<void> initEnv(String type) async {
  String jsonString = await rootBundle.loadString(
    'assets/environments/$type.yaml',
  );
  Map json = loadYaml(jsonString);
  Env.instance.parse(json);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Env.instance.appBuildNumber = int.parse(
      (packageInfo?.buildNumber ?? '').isEmpty
          ? kAppBuildNumber
          : packageInfo.buildNumber);
  Env.instance.appVersion = packageInfo.version;
}

class Env {
  Env._();

  /// The shared instance of [Env].
  static final Env instance = Env._();

  void parse(Map json) {
    this.env = json['env'];
    this.webUrl = json['webUrl'];
    this.apiUrl = json['apiUrl'];
  }

  String env;

  String webUrl;
  String apiUrl;

  int appBuildNumber = 0;
  String appVersion = '0.0.0';
}
