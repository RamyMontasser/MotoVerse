import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';
// import 'package:motoverse/Features/settings/data/repo/settings_repo.dart';

part 'identity_verification_state.dart';

class IdentityVerificationCubit extends Cubit<IdentityVerificationState> {
  final ProfileCarRepo profileCarRepo;
  IdentityVerificationCubit({required this.profileCarRepo})
    : super(IdentityVerificationInitial());

  Future<void> verifyIdentity({
    required XFile frontId,
    required XFile backId,
    required XFile faceImage,
  }) async {
    emit(IdentityVerificationLoading());
    final result = await profileCarRepo.verifyIdentity(
      frontId: frontId,
      backId: backId,
      faceImage: faceImage,
    );

    result.fold(
      (failure) {
        debugPrint(failure.errorMsg);
        emit(IdentityVerificationFailure('برجاء ادخال الصور المطلوبة بشكل صحيح'));
      },
      (response) {
        debugPrint(response.toString());
         debugPrint('sucessssss');

        if (response['is_verified'] == true) {
          emit(IdentityVerificationSuccess(response));
        } else {
          emit(IdentityVerificationFailure("فشل التحقق من الهوية"));
        }
      },
      // debugPrint(response.message);
      // debugPrint("successssssssss");
      // emit(IdentityVerificationSuccess(response));},
    );
  }
}
