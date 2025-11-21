import 'package:dio/dio.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

UniOcrClientError toUniOcrClientError(DioException error) {
  Response? response = error.response;
  if (response?.data == null && response?.data is! Map) {
    return UniOcrClientError(
      code: 'unknown',
      message: response?.data ?? error.message,
    );
  }
  return UniOcrClientError(
    code: '${response?.data['code']}',
    message: response?.data['message'],
  );
}
