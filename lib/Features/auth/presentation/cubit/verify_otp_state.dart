part of 'verify_otp_cubit.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}

final class VerifyOtpSuccess extends VerifyOtpState {
  final PhoneEntity phoneEntity;
  VerifyOtpSuccess({required this.phoneEntity});
}

final class VerifyOtpFailure extends VerifyOtpState {
  final String msg;
  VerifyOtpFailure({required this.msg});
}
