import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';

abstract class ProfileCarRepo {
  Future<Either<Failure, List<CarModel>>> getCars();
  Future<Either<Failure, void>> addCar(CarModel car);
  Future<Either<Failure, void>> updateCar(int id, CarModel car);
  Future<Either<Failure, void>> deleteCar(int id);

  Future<Either<Failure, dynamic>> verifyIdentity({
    required XFile frontId,
    required XFile backId,
    required XFile faceImage,
  });
}
