import 'dart:async';
import 'package:dio/dio.dart';

import '../../../includes.dart';

class OcrEnginesApi {
  final Dio _http;

  String? _ocrEngineId;

  OcrEnginesApi(this._http);

  void setOcrEngineId(String? id) {
    _ocrEngineId = id;
  }

  Future<List<OcrEngineConfig>> list() async {
    final response = await _http.get('/ocr_engines');

    List<OcrEngineConfig> list = (response.data as List)
        .map((e) => OcrEngineConfig.fromJson(e))
        .toList();
    return list;
  }

  Future<OcrEngineConfig> get() async {
    final response = await _http.get('/ocr_engines/$_ocrEngineId');

    var d = OcrEngineConfig.fromJson(response.data['data']);
    return d;
  }

  Future<RecognizeTextResponse> recognizeText(
      RecognizeTextRequest request) async {
    try {
      final response = await _http.post(
        '/ocr_engines/$_ocrEngineId/recognizeText',
        data: {
          'base64Image': request.getBase64Image(),
        },
      );
      return RecognizeTextResponse.fromJson(response.data);
    } on DioError catch (error) {
      Response? response = error.response;
      throw UniOcrClientError(
        code: '${response?.statusCode}',
        message: response?.data['message'],
      );
    }
  }
}
