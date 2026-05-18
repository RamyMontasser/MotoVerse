import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';
import 'package:motoverse/Features/map/domain/repo/service_center_repo.dart';

class ServiceCenterRepoImp implements ServiceCenterRepo {
  final NetworkService networkService;
  final SecureStorage secureStorage;

  ServiceCenterRepoImp({
    required this.networkService,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, List<ServiceCenterModel>>> getServiceCenters({
    required double lat,
    required double long,
  }) async {
    try {
      // final token = await secureStorage.getAccessToken();
      final response = await networkService.getData(
        endPoint: '/service-centers/service-centers/',
        queryParameters: {'latitude': lat, 'longitude': long},
        // token: token,
      );

      List<ServiceCenterModel> centers = [];
      if (response is List) {
        centers = response.map((e) => ServiceCenterModel.fromJson(e)).toList();
      } else if (response is Map<String, dynamic>) {
        var data = response['data'] ?? response['results'] ?? [];
        if (data is List) {
          centers = data.map((e) => ServiceCenterModel.fromJson(e)).toList();
        }
      }

      return right(centers);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ApiFailure(errorMsg: e.toString()));
    }
  }

}
