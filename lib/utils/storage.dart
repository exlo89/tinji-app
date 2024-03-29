import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tinji/models/match_user.dart';
import 'package:tinji/models/tinji_match.dart';
import 'package:tinji/models/user.dart';

class Storage {
  static final _singleton = Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Storage._internal() {
    init();
  }

  init() async {
    accessToken = await secureStorage.read(key: 'access_token') ?? '';
  }

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  //====== AUTH ======
  String accessToken;
  bool isLoggedIn;
  User user;
  List<User> matchUsers;
  List<TinjiMatch> matches;
}
