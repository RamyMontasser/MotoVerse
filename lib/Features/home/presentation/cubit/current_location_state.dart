part of 'current_location_cubit.dart';

@immutable
sealed class CurrentLocationState {}

final class CurrentLocationInitial extends CurrentLocationState {}
final class CurrentLocationLoading extends CurrentLocationState {}
final class CurrentLocationSuccess extends CurrentLocationState {
  final Position currentLocation;
  final String? cityName;

  CurrentLocationSuccess({required this.currentLocation, this.cityName});
}
final class CurrentLocationFailure extends CurrentLocationState {
  final String errMsg;

  CurrentLocationFailure({required this.errMsg});
}
