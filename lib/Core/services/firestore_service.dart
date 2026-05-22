// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:motoverse/Features/chat/data/models/message_model.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String? get _userId => FirebaseAuth.instance.currentUser?.uid;



//    // CREATE CHAT
//   // =========================
//   Future<void> createChat({
//     required String chatId,
//     required String userId,
//     required String otherUserId,
//     required String requestId,
//     required String offerId,
//   }) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final chatDoc = await chatRef.get();
//     if (chatDoc.exists) return;

//     await chatRef.set({
//       "participants": [userId, otherUserId],
//       "requestId": requestId,
//       "offerId": offerId,
//       "status": "active",
//       "createdAt": FieldValue.serverTimestamp(),
//       "lastMessage": "",
//     });
//   }

//   // =========================
//   // GET MESSAGES STREAM
//   // =========================
//   Stream<List<MessageModel>> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs
//               .map((doc) => MessageModel.fromJson(doc.data()))
//               .toList();
//         });
//   }

//   // =========================
//   // SEND MESSAGE
//   // =========================
//   Future<void> sendMessage({
//     required String chatId,
//     required String message,
//   }) async {
//     if (message.trim().isEmpty) return;

//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final chatDoc = await chatRef.get();

//     if (!chatDoc.exists) return;

//     if (chatDoc.data()?['status'] == 'closed') return;

//     final userId = _userId;
//     if (userId == null) return;

//     await chatRef.collection('messages').add({
//       "type": "text",
//       "senderId": userId,
//       "text": message.trim(),
//       "timestamp": FieldValue.serverTimestamp(),
//     });

//     await chatRef.update({"lastMessage": message.trim()});
//   }

//   // =========================
//   // SEND SYSTEM MESSAGE
//   // =========================
//   Future<void> sendSystemMessage({
//     required String chatId,
//     required String text,
//   }) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final chatDoc = await chatRef.get();
//     if (!chatDoc.exists) return;

//     await chatRef.collection('messages').add({
//       "type": "system",
//       "text": text,
//       "timestamp": FieldValue.serverTimestamp(),
//     });
//   }

//   // =========================
//   // WORKER COMPLETES OFFER
//   // =========================
//   Future<void> completeOfferChat({
//     required String chatId,
//     required String offerId,
//   }) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final offerRef = _firestore.collection('offers').doc(offerId);

//     final chatDoc = await chatRef.get();
//     if (!chatDoc.exists) return;

//     final batch = _firestore.batch();

//     batch.update(offerRef, {"status": "completed"});

//     batch.update(chatRef, {"status": "waiting_review"});

//     final messageRef = chatRef.collection('messages').doc();

//     batch.set(messageRef, {
//       "type": "system",
//       "text": "مقدم الخدمة أنهى الطلب. سيتم إغلاق المحادثة بعد مراجعتك.",
//       "timestamp": FieldValue.serverTimestamp(),
//     });

//     await batch.commit();
//   }

//   // =========================
//   // CLOSE CHAT (FINAL DELETE FLOW)
//   // =========================
//   Future<void> closeChat({required String chatId, required bool solved}) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final chatDoc = await chatRef.get();
//     if (!chatDoc.exists) return;

//     final messages = await chatRef.collection('messages').get();

//     final batch = _firestore.batch();

//     // delete messages
//     for (final doc in messages.docs) {
//       batch.delete(doc.reference);
//     }

//     // delete chat
//     batch.delete(chatRef);

//     // system message (optional — may fail after delete if not careful)
//     // الأفضل يتعمل قبل الحذف لو محتاجه

//     await batch.commit();
//   }

//   // =========================
//   // MARK CHAT AS SEEN (lastSeen system)
//   // =========================
//   Future<void> markChatAsSeen(String chatId) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);

//     final chatDoc = await chatRef.get();
//     if (!chatDoc.exists) return;

//     final userId = _userId;
//     if (userId == null) return;

//     await chatRef.update({"lastSeen.$userId": FieldValue.serverTimestamp()});
//   }
  
//   // Future<void> createChat(String chatId, String userId, String otherUserId) async {
//   //   await _firestore.collection('chats').doc(chatId).set({
//   //     "participants": [userId, otherUserId],
//   //   }, SetOptions(merge: true));
//   // }

//   // Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshotStream(String chatId) {
//   //   return _firestore
//   //       .collection('chats')
//   //       .doc(chatId)
//   //       .collection('messages')
//   //       .orderBy('timestamp', descending: true)
//   //       .snapshots();
//   //       }

//   // Stream<List<MessageModel>> getMessages(String chatId) {
//   //   return _firestore
//   //       .collection('chats')
//   //       .doc(chatId)
//   //       .collection('messages')
//   //       .orderBy('timestamp', descending: true)
//   //       .snapshots()
//   //       .map((snapshot) => snapshot.docs
//   //           .map((doc) => MessageModel.fromJson(doc.data()))
//   //           .toList());
//   // }

//   //  Future<void> sendMessage(String chatId,String message) async {
//   //   if (message.trim().isEmpty) return;
//   //   if (chatId.isEmpty) return;

//   //   await _firestore.collection('chats').doc(chatId).collection('messages').add({
//   //     "senderId": _userId,
//   //     "text": message.trim(),
//   //     "timestamp": FieldValue.serverTimestamp(),
//   //   });
//   // }

//   // Future<void> deleteChat(String chatId) async {
//   //   final messages = await _firestore
//   //       .collection('chats')
//   //       .doc(chatId)
//   //       .collection('messages')
//   //       .get();
//   //   for (var message in messages.docs) {
//   //     await message.reference.delete();
//   //   }
//   //   await _firestore.collection('chats').doc(chatId).delete();
//   //   // await _firestore.collection('users').doc(_userId).collection('chats').doc(chatId).delete();
//   // }
// }