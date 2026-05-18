part of 'confirm_reset_pass_cubit.dart';

@immutable
sealed class ConfirmResetPassState {}

final class ConfirmResetPassInitial extends ConfirmResetPassState {}
final class ConfirmResetPassLoading extends ConfirmResetPassState {}
final class ConfirmResetPassSuccess extends ConfirmResetPassState {}
final class ConfirmResetPassFailure extends ConfirmResetPassState {
  final String msg;

  ConfirmResetPassFailure({required this.msg});
}
