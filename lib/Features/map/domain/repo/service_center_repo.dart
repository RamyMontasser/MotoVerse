import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';

abstract class ServiceCenterRepo {
  Future<Either<Failure, List<ServiceCenterModel>>> getServiceCenters({
    required double lat,
    required double long,
  });
}
