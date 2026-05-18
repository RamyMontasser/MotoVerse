part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class CreateChatSuccess extends ChatState {}

final class CreateChatLoading extends ChatState {}

final class CreateChatError extends ChatState {
  final String errorMsg;
  CreateChatError({required this.errorMsg});
}


final class GetMessagesSuccess extends ChatState {
  final List<MessageModel> messages;
  GetMessagesSuccess({required this.messages});
}

final class GetMessagesLoading extends ChatState {}

final class GetMessagesError extends ChatState {
  final String errorMsg;
  GetMessagesError({required this.errorMsg});
}

final class SendMessageSuccess extends ChatState {}

final class SendMessageLoading extends ChatState {}

final class SendMessageError extends ChatState {
  final String errorMsg;
  SendMessageError({required this.errorMsg});
}

final class DeleteChatSuccess extends ChatState {}

final class DeleteChatLoading extends ChatState {}

final class DeleteChatError extends ChatState {
  final String errorMsg;
  DeleteChatError({required this.errorMsg});
}
