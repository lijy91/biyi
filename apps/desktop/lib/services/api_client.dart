import 'package:biyi_api_client/biyi_api_client.dart';
import 'package:flutter/foundation.dart';
export 'package:biyi_api_client/biyi_api_client.dart' hide ApiClient;

ApiClient apiClient = ApiClient(
  // baseUrl: 'http://localhost:3000',
  debug: kDebugMode,
);
