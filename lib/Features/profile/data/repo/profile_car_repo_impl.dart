import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';

class ProfileCarRepoImpl implements ProfileCarRepo {
  final NetworkService networkService;

  ProfileCarRepoImpl({required this.networkService});

  @override
  Future<Either<Failure, List<CarModel>>> getCars() async {
    try {
      final List<dynamic> response = await networkService.getData(
        endPoint: AppConstants.getCars,
      );
      final List<CarModel> cars = response
          .map((item) => CarModel.fromJson(item))
          .toList();
      return Right(cars);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCar(CarModel car) async {
    try {
      await networkService.addData(
        endPoint: AppConstants.createCar,
        data: car.toJsonForSave(),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCar(int id, CarModel car) async {
    try {
      await networkService.patchData(
        endPoint: '${AppConstants.getCars}$id/update/',
        data: car.toJsonForSave(),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCar(int id) async {
    try {
      await networkService.deleteData(
        endPoint: '${AppConstants.getCars}$id/delete/',
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

   @override
  Future<Either<Failure, dynamic>> verifyIdentity({
    required XFile frontId,
    required XFile backId,
    required XFile faceImage,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'front_id': await MultipartFile.fromFile(
          frontId.path,
          filename: frontId.name,
        ),
        'back_id': await MultipartFile.fromFile(
          backId.path,
          filename: backId.name,
        ),
        'face_image': await MultipartFile.fromFile(
          faceImage.path,
          filename: faceImage.name,
        ),
      });

      var response = await networkService.addFormData(
        endPoint: AppConstants.verifyAcc,
        data: formData,
        options: Options(
          sendTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 2),
        ),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ApiFailure(errorMsg: e.toString()));
    }
  }
}
