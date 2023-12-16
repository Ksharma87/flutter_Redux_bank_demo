import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/data/models/auth/request/login_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RestApi restApi;

  AuthRepositoryImpl({required this.restApi});

  @override
  Future<Result<LoginResponseEntity, LoginResponseErrorEntity>> doCreateAccount(
      String email, String pwd) async {
    return await restApi
        .createAccountApi(LoginRequest(email: email, password: pwd));
  }

  @override
  Future<Result<LoginResponseEntity, LoginResponseErrorEntity>> doLoginPassword(
      String email, String pwd) async {
    return await restApi
        .loginWithPasswordApi(LoginRequest(email: email, password: pwd));
  }

  @override
  Future<void> doLogout() async {}

  @override
  Future<String?> doEmailLinkedDataBase(String email) async {
    String emailEncode = base64.encode(utf8.encode(email));
    return await restApi.getUniqueMobileNumberEmail(emailEncode);
  }
}
