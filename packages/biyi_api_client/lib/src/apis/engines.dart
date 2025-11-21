import 'dart:async';
import 'package:biyi_api_client/src/models/translation_engine_config.dart';
import 'package:biyi_api_client/src/utils/to_uni_translate_client_error.dart';
import 'package:dio/dio.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class EnginesApi {
  EnginesApi(this._dio, {this.engineId});

  final Dio _dio;
  final String? engineId;

  /// List all translation engines.
  Future<List<TranslationEngineConfig>> list() async {
    final response = await _dio.get('/api/engines');
    return (response.data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .map((e) => TranslationEngineConfig.fromJson(e))
        .toList();
  }

  /// Get an engine.
  Future<TranslationEngineConfig> get() async {
    if (engineId == null) {
      throw UnsupportedError('Please provide an engine id.');
    }
    final response = await _dio.get('/api/engines/$engineId');
    return TranslationEngineConfig.fromJson(response.data);
  }

  Future<DetectLanguageResponse> detectLanguage(
    DetectLanguageRequest request,
  ) async {
    try {
      final response = await _dio.get(
        '/api/engines/$engineId/detectLanguage',
        queryParameters: {'text': request.texts.first},
      );
      return DetectLanguageResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw toUniTranslateClientError(error);
    }
  }

  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    try {
      final response = await _dio.get(
        '/api/engines/$engineId/lookUp',
        queryParameters: request.toJson(),
      );
      return LookUpResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw toUniTranslateClientError(error);
    }
  }

  Future<TranslateResponse> translate(TranslateRequest request) async {
    try {
      final response = await _dio.get(
        '/api/engines/$engineId/translate',
        queryParameters: request.toJson(),
      );
      return TranslateResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw toUniTranslateClientError(error);
    }
  }
}
