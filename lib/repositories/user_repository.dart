import 'package:tinji/data_providers/user_provider.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/utils/storage.dart';

class UserRepository {
  final UserProvider userProvider = UserProvider();

  Future<String> authentication({String email, String password}) async {
    try {
      String token = await userProvider.login(email, password);
      writeToken(token);
      Storage().accessToken = token;
      Storage().user = await getUser();
      Storage().isLoggedIn = true;
      return token;
    } catch (error) {
      throw error;
    }
  }

  Future<String> register({String name, String email, String password, String passwordConfirmation}) async {
    try {
      String token = await userProvider.register(name, email, password, passwordConfirmation);
      writeToken(token);
      Storage().accessToken = token;
      Storage().user = await getUser();
      Storage().isLoggedIn = true;
      return token;
    } catch (error) {
      throw error;
    }
  }

  Future<User> getUser() async {
    return await userProvider.getUser();
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
