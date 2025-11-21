import 'package:dio/dio.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

UniTranslateClientError toUniTranslateClientError(DioException error) {
  Response? response = error.response;
  if (response?.data == null || response?.data is! Map) {
    return UniTranslateClientError(
      code: 'unknown',
      message: response?.data ?? error.message,
    );
  }
  return UniTranslateClientError(
    code: '${response?.data['code']}',
    message: response?.data['message'],
  );
}
