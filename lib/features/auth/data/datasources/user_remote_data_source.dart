import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> loginWithEmailPassword(String email, String password);

  Future<UserModel> loginWithOAuth(
      String provider, String code, String redirectUri);

  Future<UserModel> registerWithEmailPassword(
      String email, String password, String username);

  Future<void> logout(TokenModel tokensToLogout);

  Future<TokenModel> getNewToken(String refreshToken);
  Future<bool> checkTokenValidation(String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> loginWithEmailPassword(
      String email, String password) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> loginWithOAuth(
      String provider, String code, String redirectUri) async {
    final uri = Uri.parse('${AppConstants.baseUrl}signin/$provider/');
    print(uri.replace(queryParameters: {
        'code': code,
        'redirect_uri': redirectUri,
      }));
    final response = await client.get(
      uri.replace(queryParameters: {
        'code': code,
        'redirect_uri': redirectUri,
      }),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword(
      String email, String password, String username) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'password': password, 'email': email}),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      throw AlreadyExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout(TokenModel tokensToLogout) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}logout/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': tokensToLogout.refreshToken}),
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TokenModel> getNewToken(String refreshToken) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}api/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      return TokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> checkTokenValidation(String token) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}api/token/verify/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'token': token}),
      );
      return response.statusCode == 200 ? true : false;
    } on Exception {
      throw ServerException();
    }
  }
}
