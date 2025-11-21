import 'dart:async';
import 'package:biyi_api_client/src/models/ocr_engine_config.dart';
import 'package:biyi_api_client/src/utils/to_uni_ocr_client_error.dart';
import 'package:dio/dio.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

class OcrEnginesApi {
  OcrEnginesApi(this._dio, {this.engineId});

  final Dio _dio;
  final String? engineId;

  /// List all OCR engines.
  Future<List<OcrEngineConfig>> list() async {
    final response = await _dio.get('/api/ocr-engines');
    return (response.data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .map((e) => OcrEngineConfig.fromJson(e))
        .toList();
  }

  /// Get an OCR engine.
  Future<OcrEngineConfig> get() async {
    if (engineId == null) {
      throw UnsupportedError('Please provide an engine id.');
    }
    final response = await _dio.get('/api/ocr-engines/$engineId');
    return OcrEngineConfig.fromJson(response.data);
  }

  /// Recognize text from an image.
  Future<RecognizeTextResponse> recognizeText(
    RecognizeTextRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/api/ocr-engines/$engineId/recognizeText',
        data: {
          'base64Image': request.getBase64Image(),
        },
      );
      return RecognizeTextResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw toUniOcrClientError(error);
    }
  }
}
