import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/data/models/create_request_model.dart';

class CommunityRepoImp implements CommunityRepo {
  final NetworkService networkService;

  CommunityRepoImp({required this.networkService});

  @override
  Future<Either<Failure, List<RequestModel>>> getRequests({bool mine = false}) async {
    try {
      final  response = await networkService.getData(
        endPoint: '/community/requests/',
        queryParameters: {
          'mine': mine,
        }
      ) ;

      List<RequestModel> requests = [];
      if (response is List) {
        requests = response.map((e) => RequestModel.fromJson(e)).toList();
      }
      // else if (response is Map<String, dynamic>) {
      //   var data = response['data'] ?? response['results'] ?? [];
      //   if (data is List) {
      //     requests = data.map((e) => RequestModel.fromJson(e)).toList();
      //   }
      // }

      return right(requests);
      // return right(requests);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createRequest(CreateRequestModel requestModel) async {
    try {
      // final formData = requestModel.toJson();
      
      final formData = FormData.fromMap({
        'description': requestModel.description,
        'problem_type': requestModel.problemType,
        'request_type': requestModel.requestType,
        'city': requestModel.city,
        if (requestModel.latitude != null) 'latitude': requestModel.latitude.toString(),
        if (requestModel.longitude != null) 'longitude': requestModel.longitude.toString(),
        
        // if (requestModel.city != null) 'city': requestModel.city,
      });

      for (var image in requestModel.images) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(image.path, filename: image.name),
        ));
      }

      await networkService.addFormData(
        endPoint: '/community/requests/',
        data: formData,
      );

      return right(null);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> cancelRequest({required int requestId}) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, dynamic>> makeOffer({required int requestId, double? lat, double? long}) async {
    try {
      var response = await networkService.addData(
        endPoint: '${AppConstants.communityRequests}$requestId/offers/',
        data: {
          "latitude": lat,
          "longitude": long,
        }
        
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(Failure(errorMsg: e.toString()));
    }
  }
}
