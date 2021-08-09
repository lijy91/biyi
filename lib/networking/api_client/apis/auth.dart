import 'dart:async';
import 'package:dio/dio.dart';

import '../../../includes.dart';

class AuthApi {
  final Dio _http;

  AuthApi(this._http);

  Future<User> register({
    String name,
    String email,
    String password,
  }) async {
    final response = await _http.post(
      '/auth/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );
    return User.fromJson(response.data['data']);
  }

  Future<User> login({
    String email,
    String password,
  }) async {
    final response = await _http.post(
      '/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );
    return User.fromJson(response.data['data']);
  }

  Future logout() async {
    await _http.post('/auth/logout');
  }
}
