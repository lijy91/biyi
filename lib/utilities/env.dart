import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

Future<void> initEnv(String type) async {
  String jsonString = await rootBundle.loadString(
    'assets/environments/$type.yaml',
  );
  Map json = loadYaml(jsonString);
  Env.instance.parse(json);
}

class Env {
  Env._();

  /// The shared instance of [Env].
  static final Env instance = Env._();

  void parse(Map json) {
    this.env = json['env'];
    this.appName = json['appName'];
    this.webUrl = json['webUrl'];
    this.apiUrl = json['apiUrl'];
    this.h5Url = json['h5Url'];
  }

  String env;
  String appName;

  String webUrl;
  String apiUrl;
  String h5Url;
}
