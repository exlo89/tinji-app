import 'package:dio/dio.dart';
import 'package:tinji/models/user.dart';
import 'package:tinji/utils/api_client.dart';
import 'package:tinji/utils/api_routes.dart';

class UserProvider {
  final ApiClient apiClient = ApiClient();

  /// authentication with username(email) and password
  Future<String> login(String email, String password) async {
    try {
      Response response = await apiClient.post(ApiRoutes.login, {
        'email': email,
        'password': password,
      });

      return response.data['access_token'];
    } catch (error) {
      throw error;
    }
  }

  /// register with name, email and password
  Future<String> register(String name, String email, String password, String passwordConfirmation) async {
    try {
      Response response = await apiClient.post(ApiRoutes.register, {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      });

      return response.data['access_token'];
    } catch (error) {
      throw error;
    }
  }

  /// get user data
  Future<User> getUser() async {
    try {
      Response response = await apiClient.get(ApiRoutes.profile);
      return User.fromMap(response.data['data']);
    } catch (error) {
      throw error;
    }
  }
}
