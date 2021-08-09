import 'package:dio/dio.dart';

import '../../includes.dart';
import 'apis/auth.dart';
import 'apis/engines.dart';
import 'apis/ocr_engines.dart';
import 'apis/users.dart';
import 'apis/versions.dart';

class ApiClient {
  Dio _http;

  AuthApi _authApi;
  EnginesApi _enginesApi;
  OcrEnginesApi _ocrEnginesApi;
  UsersApi _usersApi;
  VersionsApi _versionsApi;

  ApiClient() {
    BaseOptions options = new BaseOptions(
      baseUrl: sharedEnv.apiUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      responseType: ResponseType.json,
    );
    this._http = Dio(options);
  }

  AuthApi get auth {
    if (_authApi == null) _authApi = AuthApi(_http);
    return _authApi;
  }

  EnginesApi get engines {
    return this.engine(null);
  }

  EnginesApi engine(String id) {
    if (_enginesApi == null) _enginesApi = EnginesApi(_http);
    _enginesApi.setEngineId(id);
    return _enginesApi;
  }

  OcrEnginesApi get ocrEngines {
    return this.ocrEngine(null);
  }

  OcrEnginesApi ocrEngine(String id) {
    if (_ocrEnginesApi == null) _ocrEnginesApi = OcrEnginesApi(_http);
    _ocrEnginesApi.setOcrEngineId(id);
    return _ocrEnginesApi;
  }

  UsersApi get users {
    return this.user(null);
  }

  UsersApi user(int id) {
    if (_usersApi == null) _usersApi = UsersApi(_http);
    _usersApi.setUserId(id);
    return _usersApi;
  }

  VersionsApi get versions {
    return this.version(null);
  }

  VersionsApi version(String id) {
    if (_versionsApi == null) _versionsApi = VersionsApi(_http);
    _versionsApi.setVersionId(id);
    return _versionsApi;
  }
}

ApiClient sharedApiClient = ApiClient();
