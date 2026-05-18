part of 'identity_verification_cubit.dart';

abstract class IdentityVerificationState {}

class IdentityVerificationInitial extends IdentityVerificationState {}

class IdentityVerificationLoading extends IdentityVerificationState {}

class IdentityVerificationSuccess extends IdentityVerificationState {
  final dynamic response;
  IdentityVerificationSuccess(this.response);
}

class IdentityVerificationFailure extends IdentityVerificationState {
  final String errMessage;
  IdentityVerificationFailure(this.errMessage);
}
