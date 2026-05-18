part of 'requests_cubit.dart';

@immutable
sealed class RequestsState {}

final class RequestsInitial extends RequestsState {}

final class RequestsLoading extends RequestsState {}

final class RequestsSuccess extends RequestsState {
  final List<RequestModel> requests;
  RequestsSuccess({required this.requests});
}

final class RequestsFail extends RequestsState {
  final String errorMessage;
  RequestsFail({required this.errorMessage});
}
