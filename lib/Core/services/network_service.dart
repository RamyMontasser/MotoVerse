import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<dynamic> addData({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = true,
    String? local,
    Options? options, 
  });
  Future<dynamic> addFormData({
    required String endPoint,
    required dynamic data,
    bool requiresAuth = true,
    String? local,
    Options? options, 
  });
  Future<dynamic> addDataForSignUp({
    required String endPoint,
    required Map<String, dynamic> data,
    required String token,
    bool requiresAuth = true,
    String? local,
  });
  Future<dynamic> patchData({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = true,
    String? local,
  });
  Future<dynamic> patchFormData({
    required String endPoint,
    required dynamic data,
    bool requiresAuth = true,
    String? local,
  });
  Future<dynamic> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    String? local,
  });
  Future<dynamic> deleteData({
    required String endPoint,
    bool requiresAuth = true,
    String? local,
  });
}
