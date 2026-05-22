// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:motoverse/Features/chat/data/models/message_model.dart';
// import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';

// part 'chat_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   final ChatRepo chatRepo;
//   StreamSubscription? _messagesSubscription;

//   ChatCubit({required this.chatRepo}) : super(ChatInitial());

//   Future<void> createChat({
//     required String chatId,
//     required String userId,
//     required String otherUserId,
//     required String requestId,
//     required String offerId,
//   }) async {
//     emit(CreateChatLoading());
//     final result = await chatRepo.createChat(
//       chatId: chatId,
//       userId: userId,
//       otherUserId: otherUserId,
//       requestId: requestId,
//       offerId: offerId,
//     );
//     result.fold(
//       (failure) => emit(CreateChatError(errorMsg: failure.errorMsg)),
//       (r) => emit(CreateChatSuccess()),
//     );
//   }

//   void getMessages(String chatId) {
//     emit(GetMessagesLoading());
//     _messagesSubscription?.cancel();
//     _messagesSubscription = chatRepo.getMessages(chatId).listen((messages) {
//       emit(GetMessagesSuccess(messages: messages));
//     }, onError: (error) {
//       emit(GetMessagesError(errorMsg: error.toString()));
//     });
//   }

//   Future<void> sendMessage({
//     required String chatId,
//     required String message,
//   }) async {
//     emit(SendMessageLoading());
//     final result = await chatRepo.sendMessage(
//       chatId: chatId,
//       message: message,
//     );
//     result.fold(
//       (failure) => emit(SendMessageError(errorMsg: failure.errorMsg)),
//       (r) => emit(SendMessageSuccess()),
//     );
//   }

//   Future<void> markChatAsSeen(String chatId) async {
//     emit(MarkChatAsSeenLoading());
//     final result = await chatRepo.markChatAsSeen(chatId);
//     result.fold(
//       (failure) => emit(MarkChatAsSeenError(errorMsg: failure.errorMsg)),
//       (r) => emit(MarkChatAsSeenSuccess()),
//     );
//   }

//   Future<void> completeOfferChat({
//     required String chatId,
//     required String offerId,
//   }) async {
//     emit(CompleteOfferChatLoading());
//     final result = await chatRepo.completeOfferChat(
//       chatId: chatId,
//       offerId: offerId,
//     );
//     result.fold(
//       (failure) => emit(CompleteOfferChatError(errorMsg: failure.errorMsg)),
//       (r) => emit(CompleteOfferChatSuccess()),
//     );
//   }

//   Future<void> closeChat({
//     required String chatId,
//     required bool solved,
//   }) async {
//     emit(CloseChatLoading());
//     final result = await chatRepo.closeChat(
//       chatId: chatId,
//       solved: solved,
//     );
//     result.fold(
//       (failure) => emit(CloseChatError(errorMsg: failure.errorMsg)),
//       (r) => emit(CloseChatSuccess()),
//     );
//   }

//   Future<void> deleteChat(String chatId) async {
//     emit(DeleteChatLoading());
//     final result = await chatRepo.closeChat(chatId: chatId, solved: false);
//     result.fold(
//       (failure) => emit(DeleteChatError(errorMsg: failure.errorMsg)),
//       (r) => emit(DeleteChatSuccess()),
//     );
//   }

//   @override
//   Future<void> close() {
//     _messagesSubscription?.cancel();
//     return super.close();
//   }
// }
