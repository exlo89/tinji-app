import 'package:flutter/material.dart';
import 'package:tinji/data_provider/authentication_provider.dart';
import 'package:tinji/data_provider/user_provider.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/utils/storage.dart';

class AuthenticationRepository {
  final AuthenticationProvider authenticationProvider;
  final UserProvider userProvider;

  AuthenticationRepository({
    @required this.authenticationProvider,
    @required this.userProvider,
  }) : assert(authenticationProvider != null);

  Future<String> authentication({
    @required String email,
    @required String password,
  }) async {
    try {
      String token = await authenticationProvider.login(
        email: email,
        password: password,
      );

      writeToken(token);
      print('test');
      print(token);
      Storage().accessToken = token;
      Storage().user = User.fromJson(await userProvider.getUser());
      print('testsdsdd');

      Storage().isLoggedIn = true;
    } catch (error) {
      throw error;
    }
  }

  /// delete from keystore/keychain
  Future<void> deleteToken() async {
    await Storage().secureStorage.delete(key: 'access_token');
  }

  /// write to keystore/keychain
  Future<void> writeToken(String token) async {
    await Storage().secureStorage.write(key: 'access_token', value: token);
  }

  /// read to keystore/keychain
  Future<String> readToken() async {
    return await Storage().secureStorage.read(key: 'access_token') ?? '';
  }

  /// check if has access token
  Future<bool> hasToken() async {
    return await readToken() != '';
  }
}
