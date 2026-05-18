import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveAccessToken({required String access}) async {
    await _storage.write(key: 'access_token', value: access);
  }

  Future<void> saveRefreshToken({required String refresh}) async {
    await _storage.write(key: 'refresh_token', value: refresh);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }



  Future<void> saveVerifyToken({required String verifyToken}) async {
    await _storage.write(key: 'verification_token', value: verifyToken);
  }

  Future<String?> getVerifyToken() async {
    return await _storage.read(key: 'verification_token');
  }

  Future<void> deleteVerifyToken() async {
    return await _storage.delete(key: 'verification_token');
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
