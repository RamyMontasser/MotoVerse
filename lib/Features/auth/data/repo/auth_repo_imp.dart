import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Features/auth/data/models/phone_model.dart';
import 'package:motoverse/Features/auth/data/models/tokens_model.dart';
import 'package:motoverse/Features/auth/data/models/user_model.dart';
import 'package:motoverse/Features/auth/domain/entities/phone_entity.dart';
import 'package:motoverse/Features/auth/domain/entities/tokens_entity.dart';
import 'package:motoverse/Features/auth/domain/entities/user_entity.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final NetworkService networkService;
  final SecureStorage secureStorage;

  AuthRepoImp({required this.networkService, required this.secureStorage});

  @override
  Future<Either<Failure, dynamic>> sendOTP({required String phone}) async {
    // Map<String, String> data = {'Phone': phone};
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/send-otp/',
        data: {'phone': phone},
        requiresAuth: false,
      );
      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      // debugPrint(e.toString());
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhoneEntity>> verifyOTP({
    required String phone,
    required String code,
  }) async {
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/verify-otp/',
        data: {'phone': phone, 'code': code},
        requiresAuth: false,
      );
      debugPrint(response.toString());
      PhoneEntity phoneEntity = PhoneModel.fromjson(response).toEntity();
      return right(phoneEntity);
    } on DioException catch (e) {
      debugPrint("Verify OTP Error Status: ${e.response?.statusCode}");
      debugPrint("Verify OTP Error Data: ${e.response?.data}");
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      // debugPrint(e.toString());
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> complete({
    required UserEntity userEntity,
    required String verifyToken,
  }) async {
    try {
      var response = await networkService.addDataForSignUp(
        endPoint: '/accounts/auth/register/',
        data: UserModel.fromEntity(userEntity).toMap(),
        token: verifyToken,
        requiresAuth: false,
      );
      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokensEntity>> logIn({
    required String email,
    required String pass,
  }) async {
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/login/',
        data: {"email": email, "password": pass},
        requiresAuth: false,
      );
      TokensEntity tokensEntity = TokensModel.fromjson(response).toEntity();
      return right(tokensEntity);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> restorePassRequest({
    required String phone,
  }) async {
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/reset-password/request/',
        data: {'phone': phone},
        requiresAuth: false,
      );
      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      // debugPrint(e.toString());
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyResetPass({
    required String phoneNum,
    required String code,
  }) async {
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/reset-password/verify/',
        data: {"phone": phoneNum, "code": code},
        requiresAuth: false,
      );

      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> confirmResetPass({
    required String resetToken,
    required String password,
  }) async {
    try {
      var response = await networkService.addData(
        endPoint: '/accounts/auth/reset-password/confirm/',
        data: {"reset_token": resetToken, "password": password},
        requiresAuth: false,
      );

      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final refreshToken = await secureStorage.getRefreshToken();
      if (refreshToken != null) {
        await networkService.addData(
          endPoint: '/accounts/auth/logout/',
          data: {'refresh': refreshToken},
          // requiresAuth: false,
        );
      }
      return right(null);
    } on DioException catch (e) {
      debugPrint("Logout API Error: ${e.message}");
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      debugPrint("Logout Error: ${e.toString()}");
      return left(ApiFailure(errorMsg: e.toString()));
    } finally {
      await secureStorage.deleteTokens();
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteAccount() async {
    try {
      var response = await networkService.deleteData(
        endPoint: '/accounts/profile/delete/',
      );
      await secureStorage.deleteTokens();
      return right(response);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }
}
