import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/api_services.dart';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api_config.dart';
import 'package:flutter_redux_bank/data/models/auth/login_error_response.dart';
import 'package:flutter_redux_bank/data/models/auth/login_response.dart';
import 'package:flutter_redux_bank/data/models/auth/login_request.dart';
import 'package:flutter_redux_bank/data/models/profile/update_profile_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class RestApi {
  final RestApiConfig restApiConfig;

  RestApi({required this.restApiConfig});

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>>
      loginWithPasswordApi(LoginRequest request) async {
    String url = ApiServices.loginPassword;
    http.Response response =
        await restApiConfig.httpCallPost(url, request.toString());
    final json = jsonDecode(response.body);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return result_type.Success(LoginResponse.fromJson(json));
    } else {
      return result_type.Error(LoginErrorResponse.fromJson(json));
    }
  }

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>>
      createAccountApi(LoginRequest request) async {
    String url = ApiServices.createAccount;
    http.Response response =
        await restApiConfig.httpCallPost(url, request.toString());
    final json = jsonDecode(response.body);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return result_type.Success(LoginResponse.fromJson(json));
    } else {
      return result_type.Error(LoginErrorResponse.fromJson(json));
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    String url = ApiServices.updateProfile;
    http.Response response =
    await restApiConfig.httpCallPost(url, request.toString());
    final json = jsonDecode(response.body);
  }

}
