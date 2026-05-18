part of 'send_otp_cubit.dart';

@immutable
sealed class SendOtpState {}

final class SendOtpInitial extends SendOtpState {}

final class SendOtpLoading extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {
  // final String msg;

  // SendOtpSuccess({required this.msg});
}

final class SendOtpFailure extends SendOtpState {
  final String msg;
  SendOtpFailure({required this.msg});
}
