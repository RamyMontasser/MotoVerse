import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'restore_password_state.dart';

class RestorePasswordCubit extends Cubit<RestorePasswordState> {
  final AuthRepo authRepo;
  RestorePasswordCubit(this.authRepo) : super(RestorePasswordInitial());

  Future<void> request({required String phoneNum}) async {
    emit(RestorePasswordLoading());
    var response = await authRepo.restorePassRequest(phone: phoneNum);

    response.fold(
      (failure) {
        emit(RestorePasswordFailure(msg: failure.errorMsg));
      },
      (success) {
        emit(RestorePasswordSuccess());
      },
    );
  }
}
