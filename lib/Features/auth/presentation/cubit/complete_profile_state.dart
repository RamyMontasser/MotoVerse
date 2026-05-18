part of 'complete_profile_cubit.dart';

@immutable
sealed class CompleteProfileState {}

final class CompleteProfileInitial extends CompleteProfileState {}

final class CompleteProfileLoading extends CompleteProfileState {}

final class CompleteProfileSuccess extends CompleteProfileState {
  final String response;

  CompleteProfileSuccess({required this.response});
}

final class CompleteProfileFailure extends CompleteProfileState {
  final String msg;

  CompleteProfileFailure({required this.msg});
}
