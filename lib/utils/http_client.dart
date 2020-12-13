import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:tinji/utils/storage.dart';

class ApiClient {
  Map _getHeader() {
    Map<String, String> header = {
      'authorization': 'Bearer ' + Storage().accessToken,
    };
    return header;
  }

  Uri _buildUri(String route, [Map<String, String> param = const {}]) {
    return Uri(
      scheme: GlobalConfiguration().getValue('api_scheme'),
      host: GlobalConfiguration().getValue('api_host'),
      path: route,
      queryParameters: param,
    );
  }

  Future<http.Response> _getRequest(Uri uri) async {
    return await http.get(uri, headers: _getHeader());
  }

  Future<http.Response> _postRequest(Uri uri, [Map<String, String> body = const {}]) async {
    return await http.post(uri, headers: _getHeader(), body: body);
  }
}
