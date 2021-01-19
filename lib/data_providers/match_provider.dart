import 'package:dio/dio.dart';
import 'package:tinji/models/match_user.dart';
import 'package:tinji/models/tinji_match.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/utils/api_client.dart';
import 'package:tinji/utils/api_routes.dart';

class MatchProvider {
  final ApiClient apiClient = ApiClient();

  Future<List<User>> getMatchUsers() async {
    try {
      Response response = await apiClient.get(ApiRoutes.matchUser);
      List matchUsers = response.data['data'];
      return matchUsers.map((matchUser) => User.fromMap(matchUser)).toList();
    } catch (error) {
      throw error;
    }
  }

  Future<List<TinjiMatch>> getMatches() async {
    try {
      Response response = await apiClient.get(ApiRoutes.matches);
      List matches = response.data['data'];
      return matches.map((match) => TinjiMatch.fromMap(match)).toList();
    } catch (error) {
      throw error;
    }
  }
}
