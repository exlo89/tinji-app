import 'package:tinji/utils/storage.dart';

class UserRepository {
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
