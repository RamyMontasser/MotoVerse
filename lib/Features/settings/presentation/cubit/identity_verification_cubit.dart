import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Features/settings/data/repo/settings_repo.dart';

part 'identity_verification_state.dart';

class IdentityVerificationCubit extends Cubit<IdentityVerificationState> {
  final SettingsRepo settingsRepo;
  IdentityVerificationCubit(this.settingsRepo) : super(IdentityVerificationInitial());

  Future<void> verifyIdentity({
    required XFile frontId,
    required XFile backId,
    required XFile faceImage,
  }) async {
    emit(IdentityVerificationLoading());
    var result = await settingsRepo.verifyIdentity(
      frontId: frontId,
      backId: backId,
      faceImage: faceImage,
    );

    result.fold(
      (failure) { 
        debugPrint(failure.errorMsg);
        emit(IdentityVerificationFailure(failure.errorMsg));
      },(response) { 
        debugPrint(response.message);
        debugPrint("successssssssss");
        emit(IdentityVerificationSuccess(response));},
    );
  }
}
