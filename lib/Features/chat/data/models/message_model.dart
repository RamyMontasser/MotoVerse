class MessageModel {
  final String senderId;
  final String text;
  final String? imageUrl;
  final DateTime timestamp;
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
      'timestamp': timestamp.toIso8601String(),
      'isMe': isMe,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
      isMe: json['isMe'],
      isSeen: json['isSeen'] ?? false,
    );
  }
}
