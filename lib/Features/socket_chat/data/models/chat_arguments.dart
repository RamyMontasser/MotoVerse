class ChatArguments {
  final String chatId;
  final String chatUserId;
  final String chatUserName;
  final String? helperAvatar;
  final bool isHelper;
  final String requestId;
  final String offerId;
  final String averageRating;
  final bool helperVerified;
  final bool isOnline;

  ChatArguments({
    required this.chatId,
    required this.chatUserId,
    required this.chatUserName,
    this.helperAvatar,
    required this.isHelper,
    required this.requestId,
    required this.offerId,
    required this.averageRating,
    required this.helperVerified,
    required this.isOnline,
  });
}
