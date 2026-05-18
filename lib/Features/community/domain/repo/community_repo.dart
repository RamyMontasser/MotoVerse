import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';

import 'package:motoverse/Features/community/data/models/create_request_model.dart';

abstract class CommunityRepo {
  Future<Either<Failure, List<RequestModel>>> getRequests({bool mine = false});
  Future<Either<Failure, void>> createRequest(CreateRequestModel requestModel);
  Future<Either<Failure, void>> cancelRequest({required int requestId});
  // Future<Either<Failure, void>> acceptOffer({required int offerId});
  Future<Either<Failure, void>> makeOffer({required int requestId,double? lat, double? long });
}
