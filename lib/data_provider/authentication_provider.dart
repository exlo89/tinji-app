import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinji/utils/api_client.dart';

import 'package:http/http.dart' as http;
import 'package:tinji/utils/api_routes.dart';

class AuthenticationProvider {
  final ApiClient apiClient = ApiClient();

  /// authentication with username(email) and password
  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    try {
      Map<String, String> data = {
        'email': email,
        'password': password,
      };
      http.Response response = await apiClient.post(ApiRoutes.login, data);
      Map jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(jsonResponse);
      return jsonResponse['access_token'];
    } catch (error) {
      throw error;
    }
  }
}
