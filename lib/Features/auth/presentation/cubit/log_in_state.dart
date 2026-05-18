part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInSuccess extends LogInState {
  final TokensEntity tokensEntity;

  LogInSuccess({required this.tokensEntity});
}

final class LogInFailure extends LogInState {
  final String msg;

  LogInFailure({required this.msg});
}
