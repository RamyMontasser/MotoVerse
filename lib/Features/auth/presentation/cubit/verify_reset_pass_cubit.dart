import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'verify_reset_pass_state.dart';

class VerifyResetPassCubit extends Cubit<VerifyResetPassState> {
  final AuthRepo authRepo;
  VerifyResetPassCubit(this.authRepo) : super(VerifyResetPassInitial());



  Future<void> verify({required String phoneNum, required String code})async{
    emit(VerifyResetPassLoading());

    var response = await authRepo.verifyResetPass(phoneNum: phoneNum, code: code);

    response.fold(
      (failure){
        emit(VerifyResetPassFailure(msg: failure.errorMsg));
      }, (success){
        emit(VerifyResetPassSuccess(resetToken: success["reset_token"]));
      });
  }

    Future<void> sendOtp(String phone) async {
    emit(VerifyResetPassResendOtpLoading());

    var response = await authRepo.sendOTP(phone: phone);
    return response.fold(
      (failureMsg) {
        emit(VerifyResetPassResendOtpFailure(msg: failureMsg.errorMsg));
        // debugPrint(failureMsg.errorMsg);
      },
      (successMsg) {
        emit(VerifyResetPassResendOtpSuccess());
        // debugPrint(successMsg.toString());
      },
    );
  }
}
