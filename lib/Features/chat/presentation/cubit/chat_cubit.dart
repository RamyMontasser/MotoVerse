import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';
import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  StreamSubscription? _messagesSubscription;

  ChatCubit({required this.chatRepo}) : super(ChatInitial());

  Future<void> createChat(
      String chatId, String userId, String otherUserId) async {
    emit(CreateChatLoading());
    final result = await chatRepo.createChat(chatId, userId, otherUserId);
    result.fold(
      (failure) => emit(CreateChatError(errorMsg: failure.errorMsg)),
      (r) => emit(CreateChatSuccess())
    );
  }

  void getMessages(String chatId) {
    emit(GetMessagesLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = chatRepo.getMessages(chatId).listen((messages) {
      emit(GetMessagesSuccess(messages: messages));
    }, onError: (error) {
      emit(GetMessagesError(errorMsg: error.toString()));
    });
  }

  Future<void> sendMessage(String chatId, String message) async {
    emit(SendMessageLoading());
    final result = await chatRepo.sendMessage(chatId, message);
    result.fold(
      (failure) => emit(SendMessageError(errorMsg: failure.errorMsg)),
      (r) => emit(SendMessageSuccess())
    );
  }

  Future<void> deleteChat(String chatId) async {
    emit(DeleteChatLoading());
    final result = await chatRepo.deleteChat(chatId);
    result.fold(
      (failure) => emit(DeleteChatError(errorMsg: failure.errorMsg)),
      (r) => emit(DeleteChatSuccess())
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
