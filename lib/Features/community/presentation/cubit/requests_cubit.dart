import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final CommunityRepo communityRepo;
  RequestsCubit({required this.communityRepo}) : super(RequestsInitial());

  Future<void> fetchRequests({
    bool mine = false,
    double? latitude,
    double? longitude,
  }) async {
    emit(RequestsLoading());
    final result = await communityRepo.getRequests(
      mine: mine,
      latitude: latitude,
      longitude: longitude,
    );
    result.fold(
      (failure) => emit(RequestsFail(errorMessage: failure.errorMsg)),
      (response) {
        emit(RequestsSuccess(requests: response));
      },
    );
  }

  void removeRequest(int requestId) {
    if (state is RequestsSuccess) {
      final currentRequests = (state as RequestsSuccess).requests;
      final updatedRequests =
          currentRequests.where((r) => r.id != requestId).toList();
      emit(RequestsSuccess(requests: updatedRequests));
    }
  }
}
