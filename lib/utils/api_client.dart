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
          //print('======request=======');
          //print(options.uri);
          if (Storage().accessToken != null || Storage().accessToken != '') {
            options.headers["Authorization"] = "Bearer " + Storage().accessToken;
          }
          return options;
        },
        onResponse: (Response response) {
          //print('======response=======');
          //print(response);
          return response; // continue
        },
        onError: (DioError error) async {
          // Do something with response error
          print('======error=======');
          print(error.message);
          return error;
        },
      ),
    );
  }

  Future<Response> get(String route) async {
    return await _dio.get(
      route,
      onReceiveProgress: (int received, int total) {
        int percentage = ((received / total) * 100).floor();
        // TODO print("$percentage");
      },
    );
  }

  Future<Response> post(String route, FormData data) async {
    return await _dio.post(
      route,
      data: data,
      onSendProgress: (int sent, int total) {
        int percentage = ((sent / total) * 100).floor();
        //TODO print("$percentage");
      },
    );
  }
}
