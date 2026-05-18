import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/services/api_service.dart';
import 'package:motoverse/Features/settings/data/repo/settings_repo.dart';
import 'package:motoverse/core/errors/failure.dart';

class SettingsRepoImpl implements SettingsRepo {
  final ApiService apiService;

  SettingsRepoImpl(this.apiService);

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

      var response = await apiService.addFormData(
        endPoint: AppConstants.verifyAcc,
        data: formData,
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ApiFailure(errorMsg: e.toString()));
    }
  }
}
