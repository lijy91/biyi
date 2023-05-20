import 'dart:async';

import 'package:biyi_app/includes.dart';
import 'package:dio/dio.dart';

class EnginesApi {
  EnginesApi(this._http);

  final Dio _http;

  String? _engineId;

  void setEngineId(String? id) {
    _engineId = id;
  }

  Future<List<TranslationEngineConfig>> list() async {
    final response = await _http.get('/engines');

    List<TranslationEngineConfig> list = (response.data as List)
        .map((e) => TranslationEngineConfig.fromJson(e))
        .toList();
    return list;
  }

  Future<TranslationEngineConfig> get() async {
    final response = await _http.get('/engines/$_engineId');

    var d = TranslationEngineConfig.fromJson(response.data['data']);
    return d;
  }

  Future<DetectLanguageResponse> detectLanguage(
      DetectLanguageRequest request) async {
    try {
      final response = await _http.get(
        '/engines/$_engineId/detectLanguage',
        queryParameters: {'text': request.texts.first},
      );
      return DetectLanguageResponse.fromJson(response.data);
    } on DioError catch (error) {
      Response? response = error.response;
      throw UniTranslateClientError(
        code: '${response?.data['code']}',
        message: response?.data['message'],
      );
    }
  }

  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    try {
      final response = await _http.get(
        '/engines/$_engineId/lookUp',
        queryParameters: request.toJson(),
      );
      return LookUpResponse.fromJson(response.data);
    } on DioError catch (error) {
      Response? response = error.response;
      throw UniTranslateClientError(
        code: '${response?.data['code']}',
        message: response?.data['message'],
      );
    }
  }

  Future<TranslateResponse> translate(TranslateRequest request) async {
    try {
      final response = await _http.get(
        '/engines/$_engineId/translate',
        queryParameters: request.toJson(),
      );
      return TranslateResponse.fromJson(response.data);
    } on DioError catch (error) {
      Response? response = error.response;
      throw UniTranslateClientError(
        code: '${response?.data['code']}',
        message: response?.data['message'],
      );
    }
  }
}
