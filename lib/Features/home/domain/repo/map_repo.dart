import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:motoverse/Core/errors/failure.dart';

abstract class MapRepo {
  Future<Either<Failure, Position>> getCurrentLocation();
  Future<Either<Failure, String>> getCurrentCity({required Position position});
}
