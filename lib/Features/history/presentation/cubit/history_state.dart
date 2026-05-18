part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<CarHistoryModel> history;
  final HistorySummaryModel summary;

  HistorySuccess(this.history, this.summary);
}

class HistoryFailure extends HistoryState {
  final String errMessage;

  HistoryFailure(this.errMessage);
}

class AddHistoryLoading extends HistoryState {}

class AddHistorySuccess extends HistoryState {}

class AddHistoryFailure extends HistoryState {
  final String errMessage;

  AddHistoryFailure(this.errMessage);
}
