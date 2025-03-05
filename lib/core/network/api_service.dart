import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/app/shared_prefs/token_shared_prefs.dart';
import 'package:pet_care/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  Dio get dio => _dio;

  ApiService(this._dio, this._tokenSharedPrefs) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

    _dio.interceptors.addAll([
      _authInterceptor(),
      DioErrorInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    ]);
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final tokenResult = await _tokenSharedPrefs.getToken();

        await tokenResult.fold(
          (failure) async {
            // If token fetch fails, continue without token
            return handler.next(options);
          },
          (token) async {
            if (token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
        );
      },
    );
  }
}
