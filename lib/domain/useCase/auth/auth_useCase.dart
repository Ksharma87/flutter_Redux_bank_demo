import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class AuthUseCase {
  late AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> invokeLoginPassword(String email, String pwd) async {
    final response = await authRepository.doLoginPassword(email, pwd);
    return response;
  }

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> invokeCreateAccount(String email, String pwd) async {
    return await authRepository.doCreateAccount(email, pwd);
  }

  Future<void> invokeLogout() async {
    return await authRepository.doLogout();
  }

}
