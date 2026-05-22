import 'package:flutter/foundation.dart';
import 'package:motoverse/Features/socket_chat/data/models/text_message_model.dart';

@immutable
sealed class SocketChatState {}

final class SocketChatInitial extends SocketChatState {}

// Connection States
final class SocketChatConnectLoading extends SocketChatState {}
final class SocketChatConnectSuccess extends SocketChatState {}
final class SocketChatConnectError extends SocketChatState {
  final String errorMsg;
  SocketChatConnectError({required this.errorMsg});
}

// Messages Streaming States
final class SocketMessagesLoading extends SocketChatState {}
final class SocketMessagesSuccess extends SocketChatState {
  final List<TextMessageModel> messages;
  SocketMessagesSuccess({required this.messages});
}
final class SocketMessagesError extends SocketChatState {
  final String errorMsg;
  SocketMessagesError({required this.errorMsg});
}

// Outgoing Message States
final class SocketSendMessageLoading extends SocketChatState {}
final class SocketSendMessageSuccess extends SocketChatState {}
final class SocketSendMessageError extends SocketChatState {
  final String errorMsg;
  SocketSendMessageError({required this.errorMsg});
}

// Seen status state
final class SocketMarkAsSeenLoading extends SocketChatState {}
final class SocketMarkAsSeenSuccess extends SocketChatState {}
final class SocketMarkAsSeenError extends SocketChatState {
  final String errorMsg;
  SocketMarkAsSeenError({required this.errorMsg});
}

// Offer Completion States
final class SocketCompleteOfferLoading extends SocketChatState {}
final class SocketCompleteOfferSuccess extends SocketChatState {}
final class SocketCompleteOfferError extends SocketChatState {
  final String errorMsg;
  SocketCompleteOfferError({required this.errorMsg});
}

// Close Chat States
final class SocketCloseChatLoading extends SocketChatState {}
final class SocketCloseChatSuccess extends SocketChatState {}
final class SocketCloseChatError extends SocketChatState {
  final String errorMsg;
  SocketCloseChatError({required this.errorMsg});
}
