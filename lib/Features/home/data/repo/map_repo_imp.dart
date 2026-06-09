import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/location_service.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/home/domain/repo/map_repo.dart';

class MapRepoImp implements MapRepo{
  final LocationService locationService;
  final NetworkService networkService;

  MapRepoImp({required  this.locationService, required this.networkService});
  
  @override
  Future<Either<Failure, Position>> getCurrentLocation() async{
    try {
      Position currentLocation = await locationService.determinePosition();
    return right(currentLocation);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
    
    
  }
  
  @override
  Future<Either<Failure, String>> getCurrentCity({required Position position}) async{
    try {
      String cityName = await locationService.getCityName(position.latitude, position.longitude);
    return right(cityName);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }


  @override
  Future<Either<Failure, int>> getNearestCentersCount({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await networkService.getData(
        endPoint: '/service-centers/service-centers/nearest-count/',
        queryParameters: {'latitude': latitude, 'longitude': longitude},
      );

      // int count = 0;
      // if (response.data != null && response.data['count'] != null) {
      //   count = response.data['count'] as int;
      // }
      int count = response['count'] ?? 0;
      return right(count);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }
}