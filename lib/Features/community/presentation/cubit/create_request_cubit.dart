import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:motoverse/Features/community/domain/repo/community_repo.dart';

import 'package:motoverse/Features/community/data/models/create_request_model.dart';

part 'create_request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  final CommunityRepo communityRepo;

  CreateRequestCubit({required this.communityRepo}) : super(CreateRequestInitial());

  Future<void> createRequest(CreateRequestModel requestModel) async {
    emit(CreateRequestLoading());
    final result = await communityRepo.createRequest(requestModel);

    result.fold(
      (failure) {
        debugPrint(failure.errorMsg);
        emit(CreateRequestFail(errorMessage: failure.errorMsg));
      },
      (success) {
        debugPrint("success");
        emit(CreateRequestSuccess());
      },
    );
  }
}
