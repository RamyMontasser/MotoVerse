class TokensEntity {
  final String acccess;
  final String refresh;
  final Map<String, dynamic> expireAt;

  TokensEntity({
    required this.acccess,
    required this.refresh,
    required this.expireAt,
  });
}
