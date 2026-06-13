import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/home/data/models/notificaion_model.dart';
// import 'package:motoverse/Features/home/data/models/chat_model.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/chat/data/models/conversation_model.dart';

class HomeRepoImp implements HomeRepo {
  final NetworkService networkService;

  HomeRepoImp({required this.networkService});

  @override
  Future<Either<Failure, void>> updateProfile({required String city}) async {
    try {
      await networkService.patchData(
        endPoint: '/accounts/profile/update/',
        data: {'city': city},
      );
      debugPrint(city);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> updateUserInfo({
    // required int id,
    required String name,
    required String email,
    File? image,
    bool removeImage = false,
  }) async {
    try {
      dynamic response;

      if (image != null || removeImage) {
        final formData = FormData.fromMap({
          // 'id': id,
          'name': name,
          'email': email,
          if (removeImage) 'image': '',
          if (image != null)
            'image': await MultipartFile.fromFile(
              image.path,
              filename: image.path.split(Platform.pathSeparator).last,
            ),
        });

        response = await networkService.patchFormData(
          endPoint: '/accounts/profile/update/',
          data: formData,
        );
      } else {
        response = await networkService.patchData(
          endPoint: '/accounts/profile/update/',
          data: {
            // 'id': id,
            'name': name,
            'email': email,
          },
        );
      }

      if (response is Map<String, dynamic>) {
        return Right(UserDataModel.fromJson(response));
      }

      final userResult = await getUserInfo();
      return userResult.fold(
        (failure) => Left(failure),
        (user) => Right(user),
      );
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers({
    required int requestId,
  }) async {
    try {
      List<dynamic> response = await networkService.getData(
        endPoint: '${AppConstants.communityRequests}$requestId/offers/',
      );
      List<OfferModel> offers = [];
      offers = response.map((offer) => OfferModel.fromJson(offer)).toList();

      // for (var item in response) {
      //   offers.add(OfferModel.fromJson(item));
      // }
      return Right(offers);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, String>> getUserToken() async {
  //   try {
  //     var response = await networkService.addData(
  //       endPoint: AppConstants.getUserToken,
  //       data: {},
  //     );
  //     debugPrint(response['token']);
  //     return right(response['token']);
  //   } on DioException catch (e) {
  //     debugPrint("Dio Error Type: ${e.type}");
  //     debugPrint("Dio Error Message: ${e.message}");
  //     debugPrint("Dio Error Response: ${e.response?.data}");
  //     return left(ApiFailure.fromDioException(e));
  //   } catch (e) {
  //     return left(ServerFailure(errorMsg: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, UserDataModel>> getUserInfo() async {
    try {
      var response = await networkService.getData(
        endPoint: '/accounts/profile/',
      );
      return Right(UserDataModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOfferStatus({
    required int offerId,
    required String status,
  }) async {
    try {
      await networkService.patchData(
        endPoint: '${AppConstants.communityOffers}$offerId/status/',
        data: {'status': status},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRequest({required int requestId}) async {
    try {
      await networkService.deleteData(
        endPoint: '${AppConstants.communityRequests}$requestId/delete/',
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getMyOffers() async {
    try {
      Map<String, dynamic> response = await networkService.getData(
        endPoint: AppConstants.myOffers,
      );
      final List<dynamic> data = response['data'];

      List<OfferModel> offers = data
          .map((offer) => OfferModel.fromJson(offer))
          .toList();
      return Right(offers);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOffer({required int offerId}) async {
    try {
      await networkService.deleteData(
        endPoint: '${AppConstants.communityOffers}$offerId/delete/',
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RequestModel>> getRequestDetails({
    required int requestId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      var response = await networkService.getData(
        endPoint: '${AppConstants.communityRequests}$requestId/',
        queryParameters: {'latitude': latitude, 'longitude': longitude},
      );
      return Right(RequestModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, ChatModel>> createChat({required int requestUserId, required int offerUserId, required int requestId}) async {
  //   try {
  //     Map<String, dynamic> response = await networkService.addData(
  //       endPoint: '/chat/conversations/',
  //       data: {
  //         'request_user': requestUserId,
  //         'offer_user': offerUserId,
  //         'help_request': requestId,
  //       },
  //     );
  //     return Right(ChatModel.fromJson(response));
  //   } on DioException catch (e) {
  //     return Left(ApiFailure.fromDioException(e));
  //   } catch (e) {
  //     return Left(ServerFailure(errorMsg: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, ConversationModel>> enterChat({
    required int requestId,
  }) async {
    try {
      final response = await networkService.getData(
        endPoint: '/chat/conversations/help-request/$requestId/',
      );
      return Right(ConversationModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }



  @override
  Future<Either<Failure, void>> sendDeviceToken({required String token}) async {
    try {
      await networkService.addData(
        endPoint:
            '/notifications/fcm-token/', 
        data: {
          'token': token,
          // 'device_type': Platform.isAndroid ? 'android' : 'ios',
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      List<dynamic> response = await networkService.getData(
        endPoint: '/notifications/',
      );

      List<NotificationModel> notifications = response
          .map((item) => NotificationModel.fromJson(item))
          .toList();

      return Right(notifications);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }
  
}
