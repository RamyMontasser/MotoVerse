import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final CommunityRepo communityRepo;

  ReviewCubit({required this.communityRepo}) : super(ReviewInitial());

  Future<void> submitReview({
    required int offerId,
    required int rating,
    required String comment,
    required List<String> tags,
  }) async {
    emit(ReviewLoading());
    final result = await communityRepo.createReview(
      offerId: offerId,
      rating: rating,
      comment: comment,
      tags: tags,
    );

    result.fold(
      (failure) {
        debugPrint('Review submission failed: ${failure.errorMsg}');
        emit(ReviewFailure(errorMessage: failure.errorMsg));
      },
      (success) {
        debugPrint('Review submitted successfully');
        emit(ReviewSuccess());
      },
    );
  }
}
