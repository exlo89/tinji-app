import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:tinji/utils/storage.dart';

class ApiClient {
  static final _singleton = ApiClient._internal();

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    init();
  }

  init() async {}

  Map _getHeader() {
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: 'Bearer ' + Storage().accessToken,
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    return header;
  }

  Uri _buildUri(String route, [Map<String, String> param = const {}]) {
    return Uri(
      scheme: GlobalConfiguration().getValue('api_scheme'),
      host: GlobalConfiguration().getValue('api_host'),
      path: 'api/' + route,
      queryParameters: param,
    );
  }

  Future<http.Response> get(String route, [Map<String, String> param = const {}]) async {
    return await http.get(_buildUri(route, param), headers: _getHeader());
  }

  Future<http.Response> post(String route, [Map<String, String> body = const {}]) async {
    return await http.post(_buildUri(route), headers: _getHeader(), body: jsonEncode(body));
  }
}
