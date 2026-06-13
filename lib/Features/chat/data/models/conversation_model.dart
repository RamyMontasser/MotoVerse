import 'chat_user_model.dart';

class ConversationModel {
  final int id;
  final int helpRequest;
  final ChatUserModel requestUser;
  final ChatUserModel offerUser;
  final String createdAt;
  final String? lastMessage;

  ConversationModel({
    required this.id,
    required this.helpRequest,
    required this.requestUser,
    required this.offerUser,
    required this.createdAt,
    this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      helpRequest: json['help_request'] is int ? json['help_request'] as int : int.tryParse(json['help_request'].toString()) ?? 0,
      requestUser: ChatUserModel.fromJson(json['request_user'] is Map<String, dynamic> ? json['request_user'] as Map<String, dynamic> : {}),
      offerUser: ChatUserModel.fromJson(json['offer_user'] is Map<String, dynamic> ? json['offer_user'] as Map<String, dynamic> : {}),
      createdAt: (json['created_at'] ?? '').toString(),
      lastMessage: json['last_message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'help_request': helpRequest,
      'request_user': requestUser.toJson(),
      'offer_user': offerUser.toJson(),
      'created_at': createdAt,
      'last_message': lastMessage,
    };
  }
}