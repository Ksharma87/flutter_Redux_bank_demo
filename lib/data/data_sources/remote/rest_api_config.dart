import 'package:flutter_redux_bank/data/data_sources/remote/api_services.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@injectable
class RestApiConfig {

  Future<http.Response> httpCallPost(String url, String request) async {
    Uri uri = Uri.parse(_getServerUrl(url).toString());
    final http.Response response = await http.post(uri, body: request.toString());
    return response;
  }

  String _getServerUrl(String url) {
    StringBuffer sb = StringBuffer();
    sb.write(ApiServices.BaseURL);
    sb.write(ApiServices.ServerVersion);
    sb.write(url);
    sb.write(ApiServices.WebAPI_KEY);
    sb.write(ApiServices.WebAPI_KEY_Value);
    return sb.toString();
  }

}