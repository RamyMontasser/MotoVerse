import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/socket_chat/data/models/text_message_model.dart';
import 'package:motoverse/Features/socket_chat/data/models/file_message_model.dart';

abstract class ChatSocketRepository {
  Future<Either<Failure, void>> connectToChat({
    required String chatId,
    required String token,
  });
  
  void disconnect();
  
  Stream<List<TextMessageModel>> getMessagesStream();
  
  Future<Either<Failure, void>> sendMessage({
    required String text,
    String type = 'text',
    String? imageUrl,
    String? audioUrl,
  });

  Future<Either<Failure, void>> markChatAsSeen(String chatId);

  Future<Either<Failure, String>> uploadFile({
    required FileMessageModel fileMessage,
  });

  Future<Either<Failure, List<TextMessageModel>>> getConversationHistory({
    required String chatId,
  });

  Future<Either<Failure, void>> completeOfferChat({
    required String chatId,
    required String offerId,
  });

  Future<Either<Failure, void>> closeChat({
    required String chatId,
    required bool solved,
  });
}
