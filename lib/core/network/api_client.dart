import 'package:dio/dio.dart';
import 'package:movie_discovery_app/core/constants/api_constants.dart';

class ApiClient {
  ApiClient(this.dio) {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {
        ApiConstants.apiKeyParam: ApiConstants.apiKey,
        ApiConstants.languageParam: ApiConstants.defaultLanguage,
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
      RetryInterceptor(),
    ]);
  }

  final Dio dio;

  Future<Response<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor({this.retries = 3});

  final int retries;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra['retryCount'] == null) {
      err.requestOptions.extra['retryCount'] = 0;
    }

    final int currentRetry = err.requestOptions.extra['retryCount'] as int;

    if (currentRetry < retries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = currentRetry + 1;

      await Future<void>.delayed(Duration(seconds: currentRetry + 1));

      try {
        final response =
            await Dio().fetch<Map<String, dynamic>>(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        (err.response?.statusCode ?? 0) >= 500;
  }
}
