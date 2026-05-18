import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> createChat(String chatId, String userId, String otherUserId) async {
    await _firestore.collection('chats').doc(chatId).set({
      "participants": [userId, otherUserId],
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshotStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
        }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

   Future<void> sendMessage(String chatId,String message) async {
    if (message.trim().isEmpty) return;
    if (chatId.isEmpty) return;

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      "senderId": _userId,
      "text": message.trim(),
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteChat(String chatId) async {
    final messages = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();
    for (var message in messages.docs) {
      await message.reference.delete();
    }
    await _firestore.collection('chats').doc(chatId).delete();
    // await _firestore.collection('users').doc(_userId).collection('chats').doc(chatId).delete();
  }
}