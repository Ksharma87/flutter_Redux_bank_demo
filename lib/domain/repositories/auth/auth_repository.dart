import 'package:flutter_redux_bank/domain/entity/auth/login_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/loginerror_response_entity.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

abstract class AuthRepository {

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> doLoginPassword(LoginRequest request);

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> doCreateAccount(LoginRequest request);

  Future<void> doLogout();
}