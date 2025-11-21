import 'package:biyi_api_client/src/apis/engines.dart';
import 'package:biyi_api_client/src/apis/ocr_engines.dart';
import 'package:biyi_api_client/src/apis/versions.dart';
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({
    String? baseUrl,
    bool debug = false,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? 'https://biyi.thecode.me',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    if (debug) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
    _enginesApi = EnginesApi(_dio);
    _ocrEnginesApi = OcrEnginesApi(_dio);
    _versionsApi = VersionsApi(_dio);
  }

  late Dio _dio;

  late EnginesApi _enginesApi;
  late OcrEnginesApi _ocrEnginesApi;
  late VersionsApi _versionsApi;

  EnginesApi get engines => _enginesApi;

  EnginesApi engine(String engineId) {
    return EnginesApi(_dio, engineId: engineId);
  }

  OcrEnginesApi get ocrEngines => _ocrEnginesApi;

  OcrEnginesApi ocrEngine(String engineId) {
    return OcrEnginesApi(_dio, engineId: engineId);
  }

  VersionsApi get versions => _versionsApi;

  VersionsApi version(String id) {
    return VersionsApi(_dio, versionId: id);
  }
}
