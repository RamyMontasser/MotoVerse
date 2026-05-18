import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/core/errors/failure.dart';

abstract class SettingsRepo {
  Future<Either<Failure, dynamic>> verifyIdentity({
    required XFile frontId,
    required XFile backId,
    required XFile faceImage,
  });
}
