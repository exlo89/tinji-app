import 'dart:convert';

import 'package:tinji/utils/api_client.dart';

import 'package:http/http.dart' as http;
import 'package:tinji/utils/api_routes.dart';

class UserProvider {
  final ApiClient apiClient = ApiClient();

  /// get users data
  Future<Map<String, dynamic>> getUser() async {
    try {
      http.Response response = await apiClient.get(ApiRoutes.profile);
      Map jsonResponse = json.decode(response.body);
      if (response.statusCode != 200) {
        throw jsonResponse['message'];
      }
      return jsonResponse['data'];
    } catch (error) {
      throw error;
    }
  }
}
