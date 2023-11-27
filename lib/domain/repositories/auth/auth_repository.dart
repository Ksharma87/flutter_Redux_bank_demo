import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

abstract class AuthRepository {

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> doLoginPassword(String email, String pwd);

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> doCreateAccount(String email, String pwd);

  Future<void> doLogout();
}