import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tinji/utils/api_client.dart';

import 'package:tinji/utils/api_routes.dart';

class UserProvider {
  final ApiClient apiClient = ApiClient();

  /// get users data
  Future<Map<String, dynamic>> getUser() async {
    try {
      Response response = await apiClient.get(ApiRoutes.profile);
      Map jsonResponse = json.decode(response.data);
      if (response.statusCode != 200) {
        throw jsonResponse['message'];
      }
      return jsonResponse['data'];
    } catch (error) {
      throw error;
    }
  }
}
