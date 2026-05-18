part of 'restore_password_cubit.dart';

@immutable
sealed class RestorePasswordState {}

final class RestorePasswordInitial extends RestorePasswordState {}
final class RestorePasswordLoading extends RestorePasswordState {}
final class RestorePasswordSuccess extends RestorePasswordState {}
final class RestorePasswordFailure extends RestorePasswordState {
  final String msg;

  RestorePasswordFailure({required this.msg});
}
