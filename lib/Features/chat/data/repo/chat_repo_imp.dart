import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/firestore_service.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';
import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final FirestoreService firestoreService;

  ChatRepoImpl({required this.firestoreService});

  @override
  Future<Either<Failure, void>> createChat (
      String chatId, String userId, String otherUserId) async{
    try {
      await firestoreService.createChat(chatId, userId, otherUserId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }


  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return firestoreService.getMessages(chatId);
  }

  @override
  Future<Either<Failure, void>> sendMessage(String chatId, String message) async{
    try {
      await firestoreService.sendMessage(chatId, message);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async{
    try {
      await firestoreService.deleteChat(chatId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }
}