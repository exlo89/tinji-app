import 'package:tinji/data_providers/match_provider.dart';
import 'package:tinji/models/tinji_match.dart';
import 'package:tinji/models/user.dart';

class MatchRepository {
  final MatchProvider matchUserProvider = MatchProvider();

  Future<List<User>> fetchMatchUser() async {
    return await matchUserProvider.getMatchUsers();
  }

  Future<List<TinjiMatch>> getMatches() async {
    return await matchUserProvider.getMatches();
  }
}
