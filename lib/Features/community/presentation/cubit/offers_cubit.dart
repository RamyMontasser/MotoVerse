import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final CommunityRepo communityRepo;
  OffersCubit({required this.communityRepo}) : super(OffersInitial());
  void makeOffer({required int requestId, double? lat, double? long}) async {
    emit(MakeOfferLoading());
    var result = await communityRepo.makeOffer(
      requestId: requestId,
      lat: lat,
      long: long,
    );
    result.fold((failure) {
      emit(MakeOfferFailure(errorMsg: failure.errorMsg));
      debugPrint('failure make offer ${failure.errorMsg}');
    }, (response) {
      emit(MakeOfferSuccess());
      debugPrint('success make offer');
    });
  }
}
