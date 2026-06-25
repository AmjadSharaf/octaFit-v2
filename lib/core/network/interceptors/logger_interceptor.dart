import 'package:dio/dio.dart';
import 'package:octafit/core/services/logger_service.dart';

class DioLoggerInterceptor extends Interceptor {
  final LoggerService _logger;

  DioLoggerInterceptor(this._logger);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _logger.debug('--> ${options.method} ${options.path}');
    _logger.debug('Headers: ${options.headers}');
    if (options.data != null) {
      _logger.debug('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.debug('<-- ${response.statusCode} ${response.requestOptions.path}');
    _logger.debug('Response: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    _logger.error(
      '<-- ${err.response?.statusCode} ${err.requestOptions.path}',
    );
    handler.next(err);
  }
}
