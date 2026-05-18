import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/location_service.dart';
import 'package:motoverse/Features/home/domain/repo/map_repo.dart';

class MapRepoImp implements MapRepo{
  final LocationService locationService;

  MapRepoImp({required  this.locationService});
  
  @override
  Future<Either<Failure, Position>> getCurrentLocation() async{
    try {
      Position currentLocation = await locationService.determinePosition();
    return right(currentLocation);
    } catch (e) {
      return left(Failure(errorMsg: e.toString()));
    }
    
    
  }
  
  @override
  Future<Either<Failure, String>> getCurrentCity({required Position position}) async{
    try {
      String cityName = await locationService.getCityName(position.latitude, position.longitude);
    return right(cityName);
    } catch (e) {
      return left(Failure(errorMsg: e.toString()));
    }
  }
}