class ChatArguments {
  final String chatId;
  final String otherUserId;
  final String helperName;
  final String? helperAvatar;
  final bool isHelper;
  final String requestId;
  final String offerId;
  final String averageRating;
  final bool helperVerified;

  ChatArguments({
    required this.chatId,
    required this.otherUserId,
    required this.helperName,
    this.helperAvatar,
    required this.isHelper,
    required this.requestId,
    required this.offerId,
    required this.averageRating,
    required this.helperVerified,
  });
}
