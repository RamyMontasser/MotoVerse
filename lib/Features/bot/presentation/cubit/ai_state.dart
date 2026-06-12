part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}
final class AiChatLoading extends AiState {
  final String userMessage;
  AiChatLoading({required this.userMessage});
}

final class AiChatSuccess extends AiState {
  final String userMessage;
  final AiExplainationResponseModel aiResponse;

  AiChatSuccess({required this.userMessage, required this.aiResponse});
}

final class AiChatFailure extends AiState {
  final String errMessage;
  AiChatFailure({required this.errMessage});
}

final class AiObdLoading extends AiState {}

final class AiObdSuccess extends AiState {
  final AiObdDiagnosisResponseModel obdResponse;
  final Map<String, dynamic> body; 
  AiObdSuccess({required this.obdResponse, required this.body});
}

final class AiObdFailure extends AiState {
  final String errMessage;
  AiObdFailure({required this.errMessage});
}
