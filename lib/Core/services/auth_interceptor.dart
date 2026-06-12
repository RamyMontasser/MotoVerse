import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/services/navigator_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorage secureStorage;

  bool _isRefreshing = false;
  final List<Map<String, dynamic>> _failedRequests = [];

  AuthInterceptor({required this.dio, required this.secureStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra['requiresAuth'] ?? true;
    if (requiresAuth) {
      final token = await secureStorage.getAccessToken();
      if (token != null && !options.headers.containsKey('Authorization')) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    return handler.next(options);
  }
  @override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  final requiresAuth = err.requestOptions.extra['requiresAuth'] ?? true;

  if (requiresAuth && err.response?.statusCode == 401) {
    if (!_isRefreshing) {
      _isRefreshing = true;

      try {
        debugPrint(' بدأت عملية تجديد التوكن (Refresh Token)...');
        final refreshToken = await secureStorage.getRefreshToken();
        
        if (refreshToken == null) {
          debugPrint(' لم يتم العثور على Refresh Token في التخزين الآمن!');
          _isRefreshing = false;
          await secureStorage.deleteTokens();
          NavigatorService.pushNamedAndRemoveUntil('log in');
          return handler.next(err);
        }

        final refreshDio = Dio(BaseOptions(
          baseUrl: dio.options.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

        final response = await refreshDio.post(
          '/accounts/auth/token/refresh/', 
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint(' تم تجديد التوكن بنجاح من السيرفر.');
          
          final newAccessToken = response.data['access'] ?? response.data['access_token'];
          final newRefreshToken = response.data['refresh'] ?? response.data['refresh_token'];

          if (newAccessToken != null) {
            await secureStorage.saveAccessToken(access: newAccessToken);
            if (newRefreshToken != null) {
              await secureStorage.saveRefreshToken(refresh: newRefreshToken);
            }

            _isRefreshing = false;

            err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final retryResponse = await dio.fetch(err.requestOptions);

            for (var request in _failedRequests) {
              final options = request['options'] as RequestOptions;
              final h = request['handler'] as ErrorInterceptorHandler;
              options.headers['Authorization'] = 'Bearer $newAccessToken';
              final resp = await dio.fetch(options);
              h.resolve(resp);
            }
            _failedRequests.clear();

            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        _isRefreshing = false;
        _failedRequests.clear();
        debugPrint(' فشلت عملية الـ Refresh تماماً بسبب خطأ: $e');
        await secureStorage.deleteTokens();
        NavigatorService.pushNamedAndRemoveUntil('log in');
        return handler.next(err); 
      }
    } else {
      _failedRequests.add({'options': err.requestOptions, 'handler': handler});
      return;
    }
  }
  return handler.next(err);
}

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   final requiresAuth = err.requestOptions.extra['requiresAuth'] ?? true;

  //   if (requiresAuth && err.response?.statusCode == 401) {
  //     if (!_isRefreshing) {
  //       _isRefreshing = true;

  //       try {
  //         final refreshToken = await secureStorage.getRefreshToken();
  //         if (refreshToken == null) {
  //           _isRefreshing = false;
  //           await secureStorage.deleteTokens();
  //           NavigatorService.pushNamedAndRemoveUntil('log in');
  //           return handler.next(err);
  //         }

  //         // Use a clean Dio instance for refresh to avoid interceptor issues
  //         final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
  //         final response = await refreshDio.post(
  //           '/accounts/auth/token/refresh/',
  //           data: {'refresh': refreshToken},
  //         );

  //         if (response.statusCode == 200 || response.statusCode == 201) {
  //           final newAccessToken =
  //               response.data['access_token'] ?? response.data['access'];
  //           final newRefreshToken =
  //               response.data['refresh_token'] ?? response.data['refresh'];

  //           if (newAccessToken != null) {
  //             await secureStorage.saveAccessToken(access: newAccessToken);
  //             if (newRefreshToken != null) {
  //               await secureStorage.saveRefreshToken(refresh: newRefreshToken);
  //             }

  //             _isRefreshing = false;

  //             // Retry the original request that triggered the error
  //             err.requestOptions.headers['Authorization'] =
  //                 'Bearer $newAccessToken';
  //             final retryResponse = await dio.fetch(err.requestOptions);

  //             // Resolve all other queued failed requests
  //             for (var request in _failedRequests) {
  //               final options = request['options'] as RequestOptions;
  //               final h = request['handler'] as ErrorInterceptorHandler;
  //               options.headers['Authorization'] = 'Bearer $newAccessToken';
  //               final resp = await dio.fetch(options);
  //               h.resolve(resp);
  //             }
  //             _failedRequests.clear();

  //             return handler.resolve(retryResponse);
  //           }
  //         }
  //       } catch (e) {
  //         _isRefreshing = false;
  //         _failedRequests.clear();
  //         await secureStorage.deleteTokens();
  //         debugPrint('Token refresh failed: $e');
  //         NavigatorService.pushNamedAndRemoveUntil('log in');
  //       }
  //     } else {
  //       // Queue the request if a refresh is already in progress
  //       _failedRequests.add({'options': err.requestOptions, 'handler': handler});
  //       return;
  //     }
  //   }
  //   return handler.next(err);
  // }
}
