import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:motoverse/Features/auth/domain/entities/user_entity.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final AuthRepo authRepo;
  CompleteProfileCubit(this.authRepo) : super(CompleteProfileInitial());

  Future<void> complete({
    required UserEntity userEntity,
    required String verifyToken,
  }) async {
    emit(CompleteProfileLoading());
    var response = await authRepo.complete(
      userEntity: userEntity,
      verifyToken: verifyToken,
    );
    response.fold(
      (failure) {
        emit(CompleteProfileFailure(msg: failure.errorMsg));
      },
      (success) {
        emit(CompleteProfileSuccess(response: success['detail']));
        // debugPrint(success.toString());
      },
    );
  }
}
