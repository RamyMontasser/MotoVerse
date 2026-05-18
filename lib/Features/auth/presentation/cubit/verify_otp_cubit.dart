import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/auth/domain/entities/phone_entity.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  AuthRepo authRepo;
  VerifyOtpCubit(this.authRepo) : super(VerifyOtpInitial());

  Future<void> verifyOtp(String phone, String code) async {
    emit(VerifyOtpLoading());
    var response = await authRepo.verifyOTP(phone: phone, code: code);
    response.fold(
      (failure) {
        emit(VerifyOtpFailure(msg: failure.errorMsg));
      },
      (phoneEntity) {
        emit(VerifyOtpSuccess(phoneEntity: phoneEntity));
      },
    );
  }
}
