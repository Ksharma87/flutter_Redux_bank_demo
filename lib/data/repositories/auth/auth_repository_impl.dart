import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/loginerror_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RestApi restApi;

  AuthRepositoryImpl({required this.restApi});

  @override
  Future<Result<LoginResponseEntity, LoginResponseErrorEntity>> doCreateAccount(LoginRequest request) async {
    return await restApi.createAccountApi(request);
  }

  @override
  Future<Result<LoginResponseEntity, LoginResponseErrorEntity>> doLoginPassword(
      LoginRequest request) async {
    return await restApi.loginWithPasswordApi(request);
  }

  @override
  Future<void> doLogout() async {}
}
