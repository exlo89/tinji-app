import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tinji/utils/api_client.dart';

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
      Response response = await apiClient.get('test', data);
      Map jsonResponse = json.decode(response.data);
      print(jsonResponse);
      return jsonResponse['access_token'];
    } catch (error) {
      throw error;
    }
  }
}
