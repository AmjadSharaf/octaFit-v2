import 'package:dio/dio.dart';
import 'package:octafit/core/constants/api_constants.dart';
import 'package:octafit/core/network/interceptors/auth_interceptor.dart';
import 'package:octafit/core/network/interceptors/error_interceptor.dart';
import 'package:octafit/core/network/interceptors/logger_interceptor.dart';
import 'package:octafit/core/network/interceptors/retry_interceptor.dart';
import 'package:octafit/core/services/logger_service.dart';
import 'package:octafit/core/storage/secure_storage_service.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({
    required SecureStorageService secureStorage,
    required LoggerService loggerService,
    String? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.contentType,
        },
      ),
    );

    _dio.interceptors.addAll(
      interceptors ??
      [
        AuthInterceptor(secureStorage),
        DioLoggerInterceptor(loggerService),
        ErrorInterceptor(),
        RetryInterceptor(),
      ],
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: Options(extra: {'dio': _dio}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: {'dio': _dio}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: {'dio': _dio}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: {'dio': _dio}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: {'dio': _dio}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> upload<T>(
    String path, {
    required FormData data,
    void Function(int, int)? onSendProgress,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      options: Options(extra: {'dio': _dio}),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void removeInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}

