import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final NetworkService networkService;

  HomeRepoImp({required this.networkService});

  @override
  Future<Either<Failure, void>> updateProfile({required String city}) async {
    try {
      await networkService.patchData(
        endPoint: 'accounts/profile/update/',
        data: {'city': city},
      );
      debugPrint(city);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers({required int requestId}) async {
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
      return Left(Failure(errorMsg: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> getUserToken()async {
    try {
      var response = await networkService.getData(
        endPoint: AppConstants.getUserToken,
      );
      return Right(response['token']);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> getUserInfo() async {
    try {
      var response = await networkService.getData(
        endPoint: 'accounts/auth/me/',
      );
      return Right(UserDataModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure(errorMsg: e.toString()));
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
      return Left(Failure(errorMsg: e.toString()));
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
      return Left(Failure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getMyOffers() async {
    try {
      Map<String,dynamic> response = await networkService.getData(
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
      return Left(Failure(errorMsg: e.toString()));
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
      return Left(Failure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RequestModel>> getRequestDetails({required int requestId}) async {
    try {
      var response = await networkService.getData(
        endPoint: '${AppConstants.communityRequests}$requestId/',
      );
      return Right(RequestModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure(errorMsg: e.toString()));
    }
  }
}

