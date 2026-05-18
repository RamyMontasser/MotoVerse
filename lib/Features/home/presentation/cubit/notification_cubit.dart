import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final HomeRepo homeRepo;

  NotificationCubit(this.homeRepo) : super(NotificationInitial());

  Future<void> getOffers({required int requestId}) async {
    emit(NotificationLoading());
    var result = await homeRepo.getOffers(requestId: requestId);
    result.fold(
      (failure) => emit(NotificationFailure(failure.errorMsg)),
      (offers) => emit(NotificationSuccess(offers)),
    );
  }

  Future<void> updateOfferStatus({
    required int offerId,
    required String status,
  }) async {
    emit(UpdateOfferStatusLoading());
    var result = await homeRepo.updateOfferStatus(
      offerId: offerId,
      status: status,
    );

    result.fold(
      (failure) { 
        debugPrint(failure.errorMsg);
        emit(UpdateOfferStatusFailure(failure.errorMsg));},
      (_) { 
        debugPrint('Updated');
        emit(UpdateOfferStatusSuccess());},
    );
  }

  Future<void> deleteRequest({required int requestId}) async {
    emit(DeleteRequestLoading());
    var result = await homeRepo.deleteRequest(requestId: requestId);

    result.fold(
      (failure) => emit(DeleteRequestFailure(failure.errorMsg)),
      (_) => emit(DeleteRequestSuccess()),
    );
  }
}
