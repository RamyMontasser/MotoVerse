import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'confirm_reset_pass_state.dart';

class ConfirmResetPassCubit extends Cubit<ConfirmResetPassState> {
  final AuthRepo authRepo;
  ConfirmResetPassCubit(this.authRepo) : super(ConfirmResetPassInitial());

  Future<void> confirm({required String resetToken, required String password})async{
    emit(ConfirmResetPassLoading());

    var response = await authRepo.confirmResetPass(
      resetToken: resetToken, 
      password: password);

    response.fold(
      (failure){
        emit(ConfirmResetPassFailure(msg: failure.errorMsg));
      }, (success){
        emit(ConfirmResetPassSuccess());
      });
  }
}
