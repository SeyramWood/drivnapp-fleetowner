import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../shared/utils/constants/google.signinig.dart';

class AuthService {
  static final AuthService instance = AuthService._();
  factory AuthService() => instance;
  AuthService._();

  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> initAuth() async {
    final storedRefreshToken = await _secureStorage.read(key: REFRESH_TOKEN_KEY);

    if (storedRefreshToken == null) {
      return false;
    }

    try {
      final TokenResponse? result = await _appAuth.token(
        TokenRequest(
          clientID(),
          redirectUrl(),
          issuer: GOOGLE_ISSUER,
          refreshToken: storedRefreshToken,
        ),
      );

      return await _handleAuthResult(result);
    } catch (e, s) {
      log('Error on Refresh Token: $e - Stack: $s');
      return false;
    }
  }

  Future<bool> login() async {
    try {
      final AuthorizationTokenRequest authorizationTokenRequest =
          AuthorizationTokenRequest(
        clientID(),
        redirectUrl(),
        issuer: GOOGLE_ISSUER,
        scopes: ['email', 'profile'],
      );

      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      return await _handleAuthResult(result);
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
      return false;
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    await _secureStorage.delete(key: REFRESH_TOKEN_KEY);
    return true;
  }

  Future<bool> _handleAuthResult(TokenResponse? result) async {
    if (result != null && result.accessToken != null && result.idToken != null) {
      if (result.refreshToken != null) {
        await _secureStorage.write(
          key: REFRESH_TOKEN_KEY,
          value: result.refreshToken!,
        );
      }

      final String googleAccessToken = result.accessToken!;

      // Send request to backend with access token
      // final url = Uri.https(
      //   'api.your-server.com',
      //   '/v1/social-authentication',
      //   {
      //     'access_token': googleAccessToken,
      //   },
      // );
      // final response = await http.get(url);
      // final backendToken = response.token

      // Let's assume it has been successful and a valid token has been returned
      const String backendToken = 'TOKEN';
      if (backendToken.isNotEmpty) {
        await _secureStorage.write(
          key: BACKEND_TOKEN_KEY,
          value: backendToken,
        );
      }
      return true;
    } else {
      return false;
    }
  }

}
