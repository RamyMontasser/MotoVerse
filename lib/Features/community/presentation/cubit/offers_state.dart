part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}
final class MakeOfferLoading extends OffersState {}
final class MakeOfferSuccess extends OffersState {}
final class MakeOfferFailure extends OffersState {
  final String errorMsg;
  MakeOfferFailure({required this.errorMsg});
}
