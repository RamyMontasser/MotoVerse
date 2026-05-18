import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageModel {
  final String senderId;
  final String text;
  final String? imageUrl;
  final Timestamp timestamp;
  final bool isMe;
  final bool isSeen;

  MessageModel({
    required this.senderId,
    required this.text,
    this.imageUrl,
    required this.timestamp,
    required this.isMe,
    this.isSeen = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toDate(),
      'isMe': isMe,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'] ?? Timestamp.now(),
      isMe: json['senderId'] == FirebaseAuth.instance.currentUser?.uid,
      isSeen: json['isSeen'] ?? false,
    );
  }
}
