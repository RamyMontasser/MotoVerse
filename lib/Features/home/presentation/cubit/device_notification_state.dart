part of 'device_notification_cubit.dart';

@immutable
sealed class DeviceNotificationState {}

final class DeviceNotificationInitial extends DeviceNotificationState {}
final class DeviceNotificationLoading extends DeviceNotificationState {}
final class DeviceNotificationSuccess extends DeviceNotificationState {
  final List<NotificationModel> notifications;
  DeviceNotificationSuccess(this.notifications);
}
final class DeviceNotificationError extends DeviceNotificationState {
  final Failure failure;
  DeviceNotificationError(this.failure);
}
