import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/secure_storage_keys.dart';

class TokenManager {
  final FlutterSecureStorage secureStorage;

  TokenManager({required this.secureStorage});

  Future<String?> get accessToken async => await secureStorage.read(key: SecureStorageKeys.accessToken);
  Future<String?> get refreshToken async => await secureStorage.read(key: SecureStorageKeys.refreshToken);

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await secureStorage.write(key: SecureStorageKeys.accessToken, value: accessToken);
    await secureStorage.write(key: SecureStorageKeys.refreshToken, value: refreshToken);
  }

  Future<void> clearTokens() async {
    await secureStorage.delete(key: SecureStorageKeys.accessToken);
    await secureStorage.delete(key: SecureStorageKeys.refreshToken);
  }

   Future<bool> isTokenExpired() async {
    final token = await accessToken;
    if (token == null) return true;
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      
      String normalizedPayload = base64Url.normalize(parts[1]);
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(normalizedPayload))
      );
      
      if (!payload.containsKey('exp')) return true;
      
      final expiration = DateTime.fromMillisecondsSinceEpoch(
        payload['exp'] * 1000,
      );
      return DateTime.now().isAfter(
        expiration.subtract(const Duration(seconds: 30))
      );
    } catch (e) {
      return true;
    }
  }
}
