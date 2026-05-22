// import 'package:dartz/dartz.dart';
// import 'package:motoverse/Core/errors/failure.dart';
// import 'package:motoverse/Features/chat/data/models/message_model.dart';

// abstract class ChatRepo {
//   Future<Either<Failure, void>> createChat({
//     required String chatId,
//     required String userId,
//     required String otherUserId,
//     required String requestId,
//     required String offerId,
//   });
//   Stream<List<MessageModel>> getMessages(String chatId);
//   Future<Either<Failure, void>> sendMessage({
//     required String chatId,
//     required String message,
//   });
//   Future<Either<Failure, void>> markChatAsSeen(String chatId);
//   Future<Either<Failure, void>> completeOfferChat({
//     required String chatId,
//     required String offerId,
//   });
//   Future<Either<Failure, void>> closeChat({
//     required String chatId,
//     required bool solved,
//   });
// }