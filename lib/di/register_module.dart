import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/jkp_constants.dart';
import 'injectable.dart';
import '../services/auth_service.dart';

@module
// Module for registering first-party dependencies
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<Dio> get dio async {
    var dio = Dio();

    dio.options = BaseOptions(contentType: 'application/json', baseUrl: apiBaseUrl);

    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        var authService = await getIt.getAsync<AuthService>();
        var accessToken = await authService.accessToken;

        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      }),
    );

    return dio;
  }
}
