import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> updateProfile({required String city});
  Future<Either<Failure, List<OfferModel>>> getOffers({required int requestId});
  Future<Either<Failure, String>> getUserToken();
  Future<Either<Failure, UserDataModel>> getUserInfo();
  Future<Either<Failure, void>> updateOfferStatus({
    required int offerId,
    required String status,
  });
  Future<Either<Failure, void>> deleteRequest({required int requestId});
  Future<Either<Failure, List<OfferModel>>> getMyOffers();
  Future<Either<Failure, void>> deleteOffer({required int offerId});
  Future<Either<Failure, RequestModel>> getRequestDetails({required int requestId});
}
