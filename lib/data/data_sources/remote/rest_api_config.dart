import 'package:flutter_redux_bank/data/data_sources/remote/api_services.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@injectable
class RestApiConfig {

  Future<http.Response> patchHttpCall(String url, String request) async {
    Uri uri = Uri.parse(url);
    final http.Response response = await http.patch(uri, body: request.toString());
    return response;
  }

  Future<http.Response> postHttpCall(String url, String request) async {
    Uri uri = Uri.parse(_getServerUrl(url).toString());
    final http.Response response = await http.post(uri, body: request.toString());
    return response;
  }

  Future<http.Response> getHttpCall(String url) async {
    Uri uri = Uri.parse(url);
    final http.Response response = await http.get(uri);
    return response;
  }

  String getFireBaseDataBaseUrl(String url) {
    String? uid = getIt<PreferencesManager>().getUid();
    return "${ApiServices.firebase_Database_URL}$url${uid!}/.json";
  }

  String getProfileDetailsUrl(String url) {
    return "${ApiServices.firebase_Database_URL}$url/.json";
  }

  String getUIDUrl(String url) {
    return "${ApiServices.firebase_Database_URL}$url/.json";
  }

  String getFireBaseDataBaseIdentityKeyUrl(String url, String key) {
    return "${ApiServices.firebase_Database_URL}$url$key.json";
  }

  String getFireBaseDataBaseUrlIdentity(String url) {
    return "${ApiServices.firebase_Database_URL}$url/.json";
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