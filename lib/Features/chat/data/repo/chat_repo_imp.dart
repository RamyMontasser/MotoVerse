// import 'package:dartz/dartz.dart';
// import 'package:motoverse/Core/errors/failure.dart';
// import 'package:motoverse/Core/services/firestore_service.dart';
// import 'package:motoverse/Features/chat/data/models/message_model.dart';
// import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';

// class ChatRepoImpl implements ChatRepo {
//   final FirestoreService firestoreService;

//   ChatRepoImpl({required this.firestoreService});

//   @override
//   Future<Either<Failure, void>> createChat({
//     required String chatId,
//     required String userId,
//     required String otherUserId,
//     required String requestId,
//     required String offerId,
//   }) async {
//     try {
//       await firestoreService.createChat(
//         chatId: chatId,
//         userId: userId,
//         otherUserId: otherUserId,
//         requestId: requestId,
//         offerId: offerId,
//       );
//       return right(null);
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }

//   @override
//   Stream<List<MessageModel>> getMessages(String chatId) {
//     return firestoreService.getMessages(chatId);
//   }

//   @override
//   Future<Either<Failure, void>> sendMessage({
//     required String chatId,
//     required String message,
//   }) async {
//     try {
//       await firestoreService.sendMessage(
//         chatId: chatId,
//         message: message,
//       );
//       return right(null);
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> markChatAsSeen(String chatId) async {
//     try {
//       await firestoreService.markChatAsSeen(chatId);
//       return right(null);
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> completeOfferChat({
//     required String chatId,
//     required String offerId,
//   }) async {
//     try {
//       await firestoreService.completeOfferChat(
//         chatId: chatId,
//         offerId: offerId,
//       );
//       return right(null);
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> closeChat({
//     required String chatId,
//     required bool solved,
//   }) async {
//     try {
//       await firestoreService.closeChat(
//         chatId: chatId,
//         solved: solved,
//       );
//       return right(null);
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }
// }