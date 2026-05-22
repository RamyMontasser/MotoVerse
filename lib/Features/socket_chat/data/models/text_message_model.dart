class TextMessageModel {
  final String messageId;
  final String type;
  final String message;
  final String? imageUrl;
  final String? audioUrl;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final bool isMe;
  final bool isSeen;

  TextMessageModel({
    required this.messageId,
    required this.type,
    required this.message,
    this.imageUrl,
    this.audioUrl,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.isMe,
    this.isSeen = false,
  });

  /// Converts the text message model to a JSON map for socket communication.
  /// Only sends the fields needed by the socket server.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
      'image': imageUrl,
      'audio': audioUrl,
    };
  }

  factory TextMessageModel.fromJson(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    final senderIdRaw = json['sender_id'] ?? json['sender'];
    final senderIdStr = senderIdRaw != null ? senderIdRaw.toString() : '';

    final messageTypeStr = (json['message_type'] ?? json['type'] ?? 'text')
        .toString();

    final timestampStr = json['timestamp']?.toString() ?? '';
    DateTime parsedTime;

    if (timestampStr.isNotEmpty) {
      final formattedTimestamp = timestampStr.contains(' ')
          ? timestampStr.replaceFirst(' ', 'T')
          : timestampStr;

      parsedTime = DateTime.tryParse(formattedTimestamp) ?? DateTime.now();
    } else {
      parsedTime = DateTime.now();
    }

    final isSeenRaw = json['is_seen'] ?? json['is_read'];

    return TextMessageModel(
      messageId: (json['message_id'] ?? json['id'] ?? '').toString(),
      type: messageTypeStr,
      message: (json['message'] ?? json['content'] ?? '')
          .toString(), 
      imageUrl: _parseStringOrMapUrl(json['image']),
      audioUrl: _parseStringOrMapUrl(json['audio']),
      senderId: senderIdStr,
      senderName: (json['sender_name'] ?? '').toString(),
      timestamp: parsedTime,
      isMe: senderIdStr.isNotEmpty && senderIdStr == currentUserId,
      isSeen:
          isSeenRaw == true || isSeenRaw?.toString().toLowerCase() == 'true',
    );
  }

  TextMessageModel copyWith({
    String? messageId,
    String? type,
    String? message,
    String? imageUrl,
    String? audioUrl,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    bool? isMe,
    bool? isSeen,
  }) {
    return TextMessageModel(
      messageId: messageId ?? this.messageId,
      type: type ?? this.type,
      message: message ?? this.message,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      isMe: isMe ?? this.isMe,
      isSeen: isSeen ?? this.isSeen,
    );
  }
}

String? _parseStringOrMapUrl(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map) {
    return value['url']?.toString() ??
        value['path']?.toString() ??
        value['link']?.toString() ??
        value['file']?.toString() ??
        value['image']?.toString();
  }
  return value.toString();
}
