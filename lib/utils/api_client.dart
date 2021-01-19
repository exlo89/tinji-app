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
    _dio.options.baseUrl = GlobalConfiguration().getValue('api_host');
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['accept'] = 'application/json';
    _dio.options.headers['X-localization'] = 'de';
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
          return response;
        },
        onError: (DioError error) async {
          // Do something with response error
          //print('======error=======');
          if (error.response.data['message'] != null) {
            return error.response.data['message'];
          } else {
            return 'Something went wrong.';
          }
        },
      ),
    );
  }

  Future<Response> get(String route) async {
    try {
      return await _dio.get(
        route,
        onReceiveProgress: (int received, int total) {
          int percentage = ((received / total) * 100).floor();
          // TODO print("$percentage");
        },
      );
    } catch (error) {
      throw error.message;
    }
  }

  Future<Response> post(String route, Map<String ,String> data) async {
    try {
      return await _dio.post(
        route,
        data: data,
        onSendProgress: (int sent, int total) {
          int percentage = ((sent / total) * 100).floor();
          //TODO print("$percentage");
        },
      );
    } catch (error) {
      throw error.message;
    }
  }
}
