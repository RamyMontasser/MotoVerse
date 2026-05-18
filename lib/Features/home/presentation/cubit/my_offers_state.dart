part of 'my_offers_cubit.dart';

@immutable
sealed class MyOffersState {}

class MyOffersInitial extends MyOffersState {}

class MyOffersLoading extends MyOffersState {}

class MyOffersSuccess extends MyOffersState {
  final List<OfferModel> offers;

  MyOffersSuccess(this.offers);
}

class MyOffersFailure extends MyOffersState {
  final String errMessage;

  MyOffersFailure(this.errMessage);
}

class DeleteOfferLoading extends MyOffersState {}

class DeleteOfferSuccess extends MyOffersState {}

class DeleteOfferFailure extends MyOffersState {
  final String errMessage;

  DeleteOfferFailure(this.errMessage);
}

class RequestDetailsLoading extends MyOffersState {}

class RequestDetailsSuccess extends MyOffersState {
  final RequestModel request;

  RequestDetailsSuccess(this.request);
}

class RequestDetailsFailure extends MyOffersState {
  final String errMessage;

  RequestDetailsFailure(this.errMessage);
}
