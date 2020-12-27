import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:tinji/utils/storage.dart';

class ApiClient {
  static final _singleton = ApiClient._internal();
  Dio _dio;

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    init();
  }

  init() async {
    _dio = new Dio();
    _dio.options.baseUrl = await GlobalConfiguration().getValue('api_host');
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          // Do something before request is sent
          print('======request=======');
          print(options);
          print(options.headers);
          print(options.uri);
          options.headers["Authorization"] = "Bearer " + Storage().accessToken;
          return options;
        },
        onResponse: (Response response) {
          // Do something with response data
          print('======response=======');
          print(response);
          print(response.headers);
          print(response.statusCode);
          return response; // continue
        },
        onError: (DioError error) async {
          // Do something with response error
          print('======error=======');
          print(error.message);
          print(error.type);
          print(error.response);
          return error;
        },
      ),
    );
  }

  Uri _buildUri(String route, [Map<String, String> param = const {}]) {
    return Uri(
      scheme: GlobalConfiguration().getValue('api_scheme'),
      host: GlobalConfiguration().getValue('api_host'),
      path: 'api/' + route,
      queryParameters: param,
    );
  }

  Future<Response> get(String route, [Map<String, String> param = const {}]) async {
    return await _dio.get(route);
  }

  Future<Response> post(String route, [Map<String, String> body = const {}]) async {
    return await _dio.post(route, data: jsonEncode(body));
  }
}
