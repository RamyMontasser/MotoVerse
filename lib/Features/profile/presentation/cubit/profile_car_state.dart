part of 'profile_car_cubit.dart';

@immutable
sealed class ProfileCarState {}

final class ProfileCarInitial extends ProfileCarState {}

final class ProfileCarLoading extends ProfileCarState {}

final class ProfileCarSuccess extends ProfileCarState {
  final List<CarModel> cars;
  ProfileCarSuccess({required this.cars});
}

final class ProfileCarFailure extends ProfileCarState {
  final String errorMsg;
  ProfileCarFailure({required this.errorMsg});
}

final class AddOrUpdateCarLoading extends ProfileCarState {}

final class AddOrUpdateCarSuccess extends ProfileCarState {}

final class AddOrUpdateCarFailure extends ProfileCarState {
  final String errorMsg;
  AddOrUpdateCarFailure({required this.errorMsg});
}
