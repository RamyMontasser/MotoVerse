import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Features/chat/data/models/file_message_model.dart';
import 'package:motoverse/Features/chat/domain/repo/chat_socket_repo.dart';
import 'package:motoverse/Features/chat/presentation/cubit/socket_chat_state.dart';

class SocketChatCubit extends Cubit<SocketChatState> {
  final ChatSocketRepository chatSocketRepo;
  StreamSubscription? _messagesSubscription;

  SocketChatCubit({required this.chatSocketRepo}) : super(SocketChatInitial());

  Future<void> connectToChatRoom({required String chatId}) async {
    emit(SocketChatConnectLoading());

    final token = await getIt<SecureStorage>().getAccessToken() ?? '';
    if (token.isEmpty) {
      emit(
        SocketChatConnectError(
          errorMsg: 'Authentication token not found. Please log in again.',
        ),
      );
      return;
    }

    final result = await chatSocketRepo.connectToChat(
      chatId: chatId,
      token: token,
    );

    result.fold(
      (failure) {
        debugPrint('SocketChatConnectError');
        debugPrint(failure.toString());
        debugPrint(failure.errorMsg);
        emit(SocketChatConnectError(errorMsg: failure.errorMsg));
      },
      (_) async {
        emit(SocketChatConnectSuccess());

        final historyResult = await chatSocketRepo.getConversationHistory(
          chatId: chatId,
        );
        historyResult.fold(
          (historyFailure) {
            debugPrint(
              'Failed to load chat history: ${historyFailure.errorMsg}',
            );
          },
          (_) {
            debugPrint('Successfully loaded and integrated chat history.');
          },
        );

        _listenToMessages();
      },
    );
  }

  void _listenToMessages() {
    emit(SocketMessagesLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = chatSocketRepo.getMessagesStream().listen(
      (messages) {
        emit(SocketMessagesSuccess(messages: messages));
      },
      onError: (error) {
        emit(SocketMessagesError(errorMsg: error.toString()));
      },
    );
  }

  Future<void> sendMessage({
    required String chatId,
    required String message,
    String type = 'text',
    String? imageUrl,
    String? audioUrl,
  }) async {
    if (message.trim().isEmpty && imageUrl == null && audioUrl == null) return;

    emit(SocketSendMessageLoading());
    final result = await chatSocketRepo.sendMessage(
      text: message.trim(),
      type: type,
      imageUrl: imageUrl,
      audioUrl: audioUrl,
    );

    result.fold(
      (failure) => emit(SocketSendMessageError(errorMsg: failure.errorMsg)),
      (_) => emit(SocketSendMessageSuccess()),
    );
  }

  Future<void> sendMediaMessage({
    required String chatId,
    required String filePath,
    required String fileType, 
  }) async {
    emit(SocketSendMessageLoading());
    debugPrint("---------------- Sending media message: $filePath, type: $fileType ----------------");

    final fileMessage = FileMessageModel(
      file: XFile(filePath),
      fileType: fileType,
    );

    final uploadResult = await chatSocketRepo.uploadFile(
      fileMessage: fileMessage,
    );

    await uploadResult.fold(
      (failure) async {
        emit(
          SocketSendMessageError(
            errorMsg: 'فشل رفع الملف: ${failure.errorMsg}',
          ),
        );
      },
      (fileUrl) async {
        debugPrint("---------------- fileUrl: $fileUrl ----------------");
        final sendResult = await chatSocketRepo.sendMessage(
          text: '',
          type: fileType,
          imageUrl: fileType == 'image' ? fileUrl : null,
          audioUrl: fileType == 'audio' ? fileUrl : null,
        );

        sendResult.fold(
          (failure) => emit(SocketSendMessageError(errorMsg: failure.errorMsg)),
          (_) => emit(SocketSendMessageSuccess()),
        );
      },
    );
  }

  Future<void> markChatAsSeen(String chatId) async {
    emit(SocketMarkAsSeenLoading());
    final result = await chatSocketRepo.markChatAsSeen(chatId);
    result.fold(
      (failure) => emit(SocketMarkAsSeenError(errorMsg: failure.errorMsg)),
      (_) => emit(SocketMarkAsSeenSuccess()),
    );
  }

  Future<void> completeOfferChat({
    required String chatId,
    required String offerId,
  }) async {
    emit(SocketCompleteOfferLoading());
    final result = await chatSocketRepo.completeOfferChat(
      chatId: chatId,
      offerId: offerId,
    );
    result.fold(
      (failure) => emit(SocketCompleteOfferError(errorMsg: failure.errorMsg)),
      (_) => emit(SocketCompleteOfferSuccess()),
    );
  }

  Future<void> closeChat({required String chatId, required bool solved}) async {
    emit(SocketCloseChatLoading());
    final result = await chatSocketRepo.closeChat(
      chatId: chatId,
      solved: solved,
    );
    result.fold(
      (failure) => emit(SocketCloseChatError(errorMsg: failure.errorMsg)),
      (_) => emit(SocketCloseChatSuccess()),
    );
  }

  Future<void> completeRequest({required String requestId}) async {
    emit(SocketRequestCompleteLoading());
    final result = await chatSocketRepo.completeRequest(requestId: requestId);
    return result.fold(
      (failure) {
        debugPrint('Failed to complete request: ${failure.errorMsg}');
        emit(SocketRequestCompleteError(errorMsg: failure.errorMsg));
      },
      (_) {
        debugPrint('Request completed successfully.');
        emit(SocketRequestCompleteSuccess());
      },
    );
  }

  void disconnectFromChat() {
    _messagesSubscription?.cancel();
    _messagesSubscription = null;

    chatSocketRepo.disconnect();

    emit(SocketChatInitial());
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    chatSocketRepo.disconnect();
    return super.close();
  }
}
