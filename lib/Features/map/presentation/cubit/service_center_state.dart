part of 'service_center_cubit.dart';

@immutable
sealed class ServiceCenterState {}

final class ServiceCenterInitial extends ServiceCenterState {}
final class ServiceCenterLoading extends ServiceCenterState {}
final class ServiceCenterSuccess extends ServiceCenterState {
  final List<ServiceCenterModel> serviceCenters;
  ServiceCenterSuccess({required this.serviceCenters});
}
final class ServiceCenterFail extends ServiceCenterState {
  final String errorMessage;
  ServiceCenterFail({required this.errorMessage});
}
final class ServiceCenterDetailsLoading extends ServiceCenterState {}
final class ServiceCenterDetailsSuccess extends ServiceCenterState {
  final ServiceCenterModel serviceCenter;
  ServiceCenterDetailsSuccess({required this.serviceCenter});
}
final class ServiceCenterDetailsFail extends ServiceCenterState {
  final String errorMessage;
  ServiceCenterDetailsFail({required this.errorMessage});
}
