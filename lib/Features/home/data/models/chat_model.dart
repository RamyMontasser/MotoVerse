class ChatModel {
  final int id;
  final int helpRequest;
  final int requestUser;
  final int offerUser;
  final DateTime createdAt;
  final String? lastMessage;

  ChatModel({
    required this.id,
    required this.helpRequest,
    required this.requestUser,
    required this.offerUser,
    required this.createdAt,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as int? ?? 0,
      helpRequest: json['help_request'] as int? ?? 0,
      requestUser: json['request_user'] as int? ?? 0,
      offerUser: json['offer_user'] as int? ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']).toLocal() 
          : DateTime.now(),
      lastMessage: json['last_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'help_request': helpRequest,
      'request_user': requestUser,
      'offer_user': offerUser,
      'created_at': createdAt.toIso8601String(),
      'last_message': lastMessage,
    };
  }
}