part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<OfferModel> offers;

  NotificationSuccess(this.offers);
}

class NotificationFailure extends NotificationState {
  final String errMessage;

  NotificationFailure(this.errMessage);
}

class UpdateOfferStatusLoading extends NotificationState {}

class UpdateOfferStatusSuccess extends NotificationState {}

class UpdateOfferStatusFailure extends NotificationState {
  final String errMessage;

  UpdateOfferStatusFailure(this.errMessage);
}

class DeleteRequestLoading extends NotificationState {}

class DeleteRequestSuccess extends NotificationState {}

class DeleteRequestFailure extends NotificationState {
  final String errMessage;

  DeleteRequestFailure(this.errMessage);
}
