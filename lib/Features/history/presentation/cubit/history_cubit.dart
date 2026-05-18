import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';
import 'package:motoverse/Features/history/data/models/history_summary_model.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepo historyRepo;

  HistoryCubit(this.historyRepo) : super(HistoryInitial());

  Future<void> getCarHistory() async {
    emit(HistoryLoading());
    final results = await Future.wait([
      historyRepo.getCarHistory(),
      historyRepo.getHistorySummary(),
    ]);

    final historyResult = results[0] as Either<Failure, List<CarHistoryModel>>;
    final summaryResult = results[1] as Either<Failure, HistorySummaryModel>;

    historyResult.fold(
      (failure) => emit(HistoryFailure(failure.errorMsg)),
      (history) {
        summaryResult.fold(
          (failure) => emit(HistoryFailure(failure.errorMsg)),
          (summary) => emit(HistorySuccess(history, summary)),
        );
      },
    );
  }

  Future<void> addHistory(CarHistoryModel history) async {
    emit(AddHistoryLoading());
    final result = await historyRepo.addHistory(history);
    result.fold(
      (failure) => emit(AddHistoryFailure(failure.errorMsg)),
      (_) => emit(AddHistorySuccess()),
    );
  }
}
