import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/utils/api_client.dart';

import 'package:tinji/utils/api_routes.dart';

class UserProvider {
  final ApiClient apiClient = ApiClient();

  /// authentication with username(email) and password
  Future<String> login(String email, String password) async {
    try {
      FormData formData = new FormData.fromMap({
        'email': email,
        'password': password,
      });
      Response response = await apiClient.post(ApiRoutes.login, formData);
      return response.data['access_token'];
    } catch (error) {
      throw error;
    }
  }

  /// get user data
  Future<User> getUser() async {
    try {
      Response response = await apiClient.get(ApiRoutes.profile);
      return User.fromJson(response.data['data']);
    } catch (error) {
      throw error;
    }
  }
}
