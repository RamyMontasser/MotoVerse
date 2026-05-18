part of 'verify_reset_pass_cubit.dart';

@immutable
sealed class VerifyResetPassState {}

final class VerifyResetPassInitial extends VerifyResetPassState {}
final class VerifyResetPassLoading extends VerifyResetPassState {}
final class VerifyResetPassSuccess extends VerifyResetPassState {
  final String resetToken;

  VerifyResetPassSuccess({required this.resetToken});
}
final class VerifyResetPassFailure extends VerifyResetPassState {
  final String msg;

  VerifyResetPassFailure({required this.msg});
}

final class VerifyResetPassResendOtpLoading extends VerifyResetPassState {}
final class VerifyResetPassResendOtpSuccess extends VerifyResetPassState {}
final class VerifyResetPassResendOtpFailure extends VerifyResetPassState {
  final String msg;

  VerifyResetPassResendOtpFailure({required this.msg});

}