part of 'obd_cubit.dart';

@immutable
sealed class ObdState {}

class ObdInitial extends ObdState {}

class ObdLoading extends ObdState {}

class ObdFinished extends ObdState {}

class ObdError extends ObdState {
  final String errorMessage;
  ObdError(this.errorMessage);
}

class ObdDataUpdated extends ObdState {
  final ObdMetrics metrics;
  ObdDataUpdated(this.metrics);
}

