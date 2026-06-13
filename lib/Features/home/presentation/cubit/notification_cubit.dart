import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/chat/data/models/conversation_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final HomeRepo homeRepo;
  List<OfferModel> offers = [];

  NotificationCubit(this.homeRepo) : super(NotificationInitial());

  Future<void> getOffers({required int requestId}) async {
    emit(NotificationLoading());
    var result = await homeRepo.getOffers(requestId: requestId);
    result.fold(
      (failure) => emit(NotificationFailure(failure.errorMsg)),
      (offersList) {
        offers = offersList;
        emit(NotificationSuccess(offersList));
      },
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

  // Future<void> createChat({required int requestUserId, required int offerUserId, required int requestId}) async {
  //   emit(CreateChatLoading());
  //   debugPrint("requestUserId : ${requestUserId.toString()}");
  //   debugPrint("offerUserId : ${offerUserId.toString()}");
  //   debugPrint("requestId : ${requestId.toString()}");
  //   var result = await homeRepo.createChat(
  //     requestUserId: requestUserId,
  //     offerUserId: offerUserId,
  //     requestId: requestId,
  //   );
  //   result.fold(
  //     (failure) => emit(CreateChatFailure(failure.errorMsg)),
  //     (chat) {
  //       debugPrint('Chat Created');
  //       emit(CreateChatSuccess(chat));
  //   });
  // }
  Future<void> enterChat({required int requestId}) async {
    emit(CreateChatLoading());
    var result = await homeRepo.enterChat(requestId: requestId);
    result.fold(
      (failure) => emit(CreateChatFailure(failure.errorMsg)),
      (chat) {
        debugPrint('Chat Created');
        emit(CreateChatSuccess(chat));
    });
  }

}
