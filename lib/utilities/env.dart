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
    this.webUrl = json['webUrl'];
    this.apiUrl = json['apiUrl'];
  }

  String env;

  String webUrl;
  String apiUrl;
}
