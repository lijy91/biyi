import 'package:biyi_app/networking/api_client/apis/engines.dart';
import 'package:biyi_app/networking/api_client/apis/ocr_engines.dart';
import 'package:biyi_app/networking/api_client/apis/versions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  ApiClient._() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://biyi-next-api.thecode.me',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      responseType: ResponseType.json,
    );
    _http = Dio(options);
    if (!kReleaseMode) {
      _http.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }

    _enginesApi = EnginesApi(_http);
    _ocrEnginesApi = OcrEnginesApi(_http);
    _versionsApi = VersionsApi(_http);
  }

  /// The shared instance of [ApiClient].
  static final ApiClient instance = ApiClient._();

  late Dio _http;

  late EnginesApi _enginesApi;
  late OcrEnginesApi _ocrEnginesApi;
  late VersionsApi _versionsApi;

  void setDebug() {
    _http.options.baseUrl = 'http://127.0.0.1:8080';
  }

  EnginesApi get engines => engine(null);

  EnginesApi engine(String? id) {
    _enginesApi.setEngineId(id);
    return _enginesApi;
  }

  OcrEnginesApi get ocrEngines => ocrEngine(null);

  OcrEnginesApi ocrEngine(String? id) {
    _ocrEnginesApi.setOcrEngineId(id);
    return _ocrEnginesApi;
  }

  VersionsApi get versions => version(null);

  VersionsApi version(String? id) {
    _versionsApi.setVersionId(id);
    return _versionsApi;
  }
}

final ApiClient apiClient = ApiClient.instance;
