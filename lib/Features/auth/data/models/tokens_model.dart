import 'package:motoverse/Features/auth/domain/entities/tokens_entity.dart';

class TokensModel {
  String accessToken;
  String refreshToken;
  Map<String,dynamic> expiresAt;
  Map<String,dynamic>? expiresIn;

  TokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.expiresIn,
  });

  
  factory TokensModel.fromjson(Map<String, dynamic> data) {
    return TokensModel(
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'],
      expiresIn: data['expires_in'],
      expiresAt: data['expires_at'],
    );
  }

  TokensEntity toEntity() {
    return TokensEntity(acccess: accessToken, refresh: refreshToken, expireAt: expiresAt);
  }

  factory TokensModel.fromEntity(TokensEntity tokensEntity) {
    return TokensModel(
      accessToken: tokensEntity.acccess,
      refreshToken: tokensEntity.refresh,
      expiresAt: tokensEntity.expireAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt,
    };
  }

}






