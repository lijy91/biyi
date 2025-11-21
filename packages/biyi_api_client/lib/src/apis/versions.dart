import 'dart:async';
import 'package:biyi_api_client/src/models/version.dart';
import 'package:dio/dio.dart';

class VersionsApi {
  VersionsApi(this._dio, {this.versionId});

  final Dio _dio;
  final String? versionId;

  /// List all versions.
  Future<List<Version>> list() async {
    final response = await _dio.get('/api/versions');
    return (response.data as List).map((e) => Version.fromJson(e)).toList();
  }

  /// Get an version.
  Future<Version> get() async {
    if (versionId == null) {
      throw UnsupportedError('Please provide a version id.');
    }
    final response = await _dio.get('/api/versions/$versionId');
    return Version.fromJson(response.data);
  }
}
