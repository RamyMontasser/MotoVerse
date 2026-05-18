import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, void>> createChat(
      String chatId, String userId, String otherUserId);
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(String chatId, String message);
  Future<Either<Failure, void>> deleteChat(String chatId);
}