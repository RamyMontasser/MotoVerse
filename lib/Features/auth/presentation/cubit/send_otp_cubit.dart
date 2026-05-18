import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  AuthRepo authRepo;
  SendOtpCubit(this.authRepo) : super(SendOtpInitial());

  Future<void> sendOtp(String phone) async {
    emit(SendOtpLoading());
    // await Future.delayed(const Duration(seconds: 2));
    // emit(SendOtpSuccess());
    var response = await authRepo.sendOTP(phone: phone);
    return response.fold(
      (failureMsg) {
        emit(SendOtpFailure(msg: failureMsg.errorMsg));
        // debugPrint(failureMsg.errorMsg);
      },
      (successMsg) {
        emit(SendOtpSuccess());
        // debugPrint(successMsg.toString());
      },
    );
  }
}
