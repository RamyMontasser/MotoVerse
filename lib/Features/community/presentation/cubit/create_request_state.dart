part of 'create_request_cubit.dart';

abstract class CreateRequestState {}

class CreateRequestInitial extends CreateRequestState {}

class CreateRequestLoading extends CreateRequestState {}

class CreateRequestSuccess extends CreateRequestState {}

class CreateRequestFail extends CreateRequestState {
  final String errorMessage;

  CreateRequestFail({required this.errorMessage});
}
