import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/api_services.dart';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api_config.dart';
import 'package:flutter_redux_bank/data/models/accounts/request/create_accounts_request.dart';
import 'package:flutter_redux_bank/data/models/accounts/response/bank_account_response.dart';
import 'package:flutter_redux_bank/data/models/auth/response/login_error_response.dart';
import 'package:flutter_redux_bank/data/models/auth/response/login_response.dart';
import 'package:flutter_redux_bank/data/models/auth/request/login_request.dart';
import 'package:flutter_redux_bank/data/models/profile/response/profile_error_response.dart';
import 'package:flutter_redux_bank/data/models/profile/response/profile_response.dart';
import 'package:flutter_redux_bank/data/models/profile/request/update_profile_request.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class RestApi {
  final RestApiConfig restApiConfig;

  RestApi({required this.restApiConfig});

  ///  Login && create Account api

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>>
      loginWithPasswordApi(LoginRequest request) async {
    String url = ApiServices.loginPassword;
    http.Response response =
        await restApiConfig.postHttpCall(url, request.toString());
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
        await restApiConfig.postHttpCall(url, request.toString());
    final json = jsonDecode(response.body);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return result_type.Success(LoginResponse.fromJson(json));
    } else {
      return result_type.Error(LoginErrorResponse.fromJson(json));
    }
  }

  //////////-----------------------------------------------------------------/////

  //  Profile Screen api

  Future<result_type.Result<ProfileResponseEntity, ProfileResponseErrorEntity>>
      getProfile(String uid) async {
    String url = restApiConfig.getProfileDetailsUrl(
        "${ApiServices.user_prefix}${ApiServices.accountDetails}$uid");
    http.Response response = await restApiConfig.getHttpCall(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return result_type.Success(ProfileResponse.fromJson(json));
    } else {
      return result_type.Error(ProfileErrorResponse.fromJson(json));
    }
  }

  ////////////////////////////////////////----////////////////

  // Details update and user new or exist api

  Future<bool> updateProfile(UpdateProfileRequest request, String uid) async {
    String url =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix}${ApiServices.accountDetails}$uid/.json";
    http.Response response =
        await restApiConfig.patchHttpCall(url, request.toString());
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateIdentity(String request) async {
    http.Response response = await restApiConfig.patchHttpCall(
        restApiConfig
            .getFireBaseDataBaseUrlIdentity(ApiServices.identity_prefix),
        request);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getUniqueMobileNumberEmail(String entity) async {
    String url = restApiConfig.getFireBaseDataBaseIdentityKeyUrl(
        ApiServices.identity_prefix, entity);
    http.Response response = await restApiConfig.getHttpCall(url);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      if (response.body == "null") {
        return null;
      } else {
        return response.body;
      }
    } else {
      return null;
    }
  }

  ////////////////////////---------------///////////////////////////////

  /// Create bank Account

  Future<BankAccountResponseEntity> getBankAccountDetails(String uid) async {
    String url = restApiConfig.getProfileDetailsUrl(
        ApiServices.user_prefix + ApiServices.bankAccount + uid);
    http.Response response = await restApiConfig.getHttpCall(url);
    final json = jsonDecode(response.body);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {}
    return BankAccountResponse.fromJson(json);
  }

  Future<bool> createBankAccount(CreateAccountsRequest request, String uid) async {
    String url =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix + ApiServices.bankAccount}$uid/.json";
    http.Response response =
        await restApiConfig.patchHttpCall(url, request.toString());
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUpdatedBalance(String uid) async {
    String url =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix}${ApiServices.bankAccount}/$uid/${ApiServices.balance}.json";
    http.Response response = await restApiConfig.getHttpCall(url);
    if (response.statusCode == ApiServices.apiStatusSuccessful) {
      return response.body.replaceAll("\"", '');
    } else {
      return '';
    }
  }

  ////      payment Transfer ///////////

  Future<bool> paymentTransfer(String selfUid, String paymentUid,
      String selfAmount, String otherAmount) async {
    String selfUrl = restApiConfig.getProfileDetailsUrl(
        "${ApiServices.user_prefix}${ApiServices.bankAccount}$selfUid");
    String otherUrl = restApiConfig.getProfileDetailsUrl(
        "${ApiServices.user_prefix}${ApiServices.bankAccount}$paymentUid");
    String request1 = "{\"balance\": \"$selfAmount\"}";
    String request2 = "{\"balance\": \"$otherAmount\"}";
    http.Response response1 =
        await restApiConfig.patchHttpCall(otherUrl, request2.toString());
    http.Response response2 =
        await restApiConfig.patchHttpCall(selfUrl, request1.toString());
    return (response1.statusCode == ApiServices.apiStatusSuccessful &&
            response2.statusCode == ApiServices.apiStatusSuccessful)
        ? true
        : false;
  }

  ///// ---------------------//////////
  Future<void> updatePassbook(
      Map<String, dynamic> request1, Map<String, dynamic> request2) async {
    String url1 =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix}${ApiServices.passBook}/${request1["uid"]}/${request1["time"]}/.json";

    String url2 =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix}${ApiServices.passBook}/${request2["uid"]}/${request2["time"]}/.json";

    String requestJson1 =
        "{\"uid\": \"${request1["uid"]}\", \"transactionType\": \"${request1["transactionType"]}\", \"balance\": \"${request1["balance"]}\", \"time\":\"${request1["time"]}\", \"amount\": \"${request1["amount"]}\"}";
    String requestJson2 =
        '{"uid": "${request2["uid"]}", "transactionType":"${request2["transactionType"]}", "balance": "${request2["balance"]}", "time":"${request2["time"]}", "amount": "${request2["amount"]}"}';

    Future<http.Response> response1 =
        restApiConfig.patchHttpCall(url2, requestJson1);
    Future<http.Response> response2 =
        restApiConfig.patchHttpCall(url1, requestJson2);
    Future.wait([response1, response2]).then((response) => {
          if (response[0].statusCode == ApiServices.apiStatusSuccessful &&
              response[1].statusCode == ApiServices.apiStatusSuccessful)
            {getPassBookList(request2["uid"])}
        });
  }

  Future<String> getPassBookList(String uid) async {
    String url =
        "${ApiServices.firebase_Database_URL}${ApiServices.user_prefix}${ApiServices.passBook}/$uid/.json";
    http.Response response = await restApiConfig.getHttpCall(url);
    return response.body;
  }
}
