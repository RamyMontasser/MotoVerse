import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

part 'my_offers_state.dart';

class MyOffersCubit extends Cubit<MyOffersState> {
  final HomeRepo homeRepo;

  MyOffersCubit(this.homeRepo) : super(MyOffersInitial());

  Future<void> getMyOffers() async {
    emit(MyOffersLoading());
    var result = await homeRepo.getMyOffers();
    result.fold(
      (failure) => emit(MyOffersFailure(failure.errorMsg)),
      (offers) => emit(MyOffersSuccess(offers)),
    );
  }

  Future<void> deleteOffer({required int offerId}) async {
    emit(DeleteOfferLoading());
    var result = await homeRepo.deleteOffer(offerId: offerId);
    result.fold(
      (failure) => emit(DeleteOfferFailure(failure.errorMsg)),
      (_) => emit(DeleteOfferSuccess()),
    );
  }

  Future<void> getRequestDetails({required int requestId}) async {
    emit(RequestDetailsLoading());
    var result = await homeRepo.getRequestDetails(requestId: requestId);
    result.fold(
      (failure) => emit(RequestDetailsFailure(failure.errorMsg)),
      (request) => emit(RequestDetailsSuccess(request)),
    );
  }
}
