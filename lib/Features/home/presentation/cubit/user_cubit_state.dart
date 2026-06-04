part of 'user_cubit_cubit.dart';

@immutable
sealed class UserCubitState {}

final class UserCubitInitial extends UserCubitState {}

final class GetUserTokenLoading extends UserCubitState {}

final class GetUserTokenSuccess extends UserCubitState {
}

final class GetUserTokenFailure extends UserCubitState {
  final String errMsg;
  GetUserTokenFailure({required this.errMsg});
}

final class GetUserInfoLoading extends UserCubitState {}

final class GetUserInfoSuccess extends UserCubitState {
  final UserDataModel user;
  GetUserInfoSuccess({required this.user});
}

final class GetUserInfoFailure extends UserCubitState {
  final String errMsg;
  GetUserInfoFailure({required this.errMsg});
}

final class UpdateUserInfoLoading extends UserCubitState {}

final class UpdateUserInfoSuccess extends UserCubitState {
  final UserDataModel user;
  UpdateUserInfoSuccess({required this.user});
}

final class UpdateUserInfoFailure extends UserCubitState {
  final String errMsg;
  UpdateUserInfoFailure({required this.errMsg});
}

