import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService {
  static const tokenKey = 'auth_token';
  static const refreshTokenKey = 'auth_refresh_token';
  static const emailKey = 'auth_email';
  static const userIdKey = 'auth_user_id';

  Future<Map<String, String?>> readSession() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      tokenKey: prefs.getString(tokenKey),
      refreshTokenKey: prefs.getString(refreshTokenKey),
      emailKey: prefs.getString(emailKey),
      userIdKey: prefs.getString(userIdKey),
    };
  }

  Future<String?> readAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
    await prefs.setString(userIdKey, userId);
    await prefs.setString(emailKey, email);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(emailKey);
    await prefs.remove(userIdKey);
  }
}
