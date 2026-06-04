import 'package:dio/dio.dart';
import 'package:motoverse/Core/services/auth_interceptor.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';

class ApiService extends NetworkService {
  final Dio dio;
  final SecureStorage secureStorage;

  ApiService({required this.dio, required this.secureStorage}) {
    dio.interceptors.add(AuthInterceptor(dio: dio, secureStorage: secureStorage));
  }
  

  @override
  Future<dynamic> addData({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};
    if (local != null) {
      header["Local"] = local;
    }
    var response = await dio.post(
      endPoint,
      data: data,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> addFormData({
    required String endPoint,
    required dynamic data,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};
    if (local != null) {
      header["Local"] = local;
    }
    var response = await dio.post(
      endPoint,
      data: data,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};
    if (local != null) {
      header["Local"] = local;
    }

    var response = await dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> patchDataForSignUp({
    required String endPoint,
    required Map<String, dynamic> data,
    required String token,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};

    header["X-Verification-Token"] = token;
    if (local != null) {
      header["Local"] = local;
    }

    var response = await dio.patch(
      endPoint,
      data: data,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> patchData({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};

    if (local != null) {
      header["Local"] = local;
    }

    var response = await dio.patch(
      endPoint,
      data: data,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> patchFormData({
    required String endPoint,
    required dynamic data,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};

    if (local != null) {
      header["Local"] = local;
    }

    var response = await dio.patch(
      endPoint,
      data: data,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> deleteData({
    required String endPoint,
    bool requiresAuth = true,
    String? local,
  }) async {
    Map<String, dynamic> header = {};
    if (local != null) {
      header["Local"] = local;
    }
    var response = await dio.delete(
      endPoint,
      options: Options(
        headers: header,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
    return response.data;
  }
}
