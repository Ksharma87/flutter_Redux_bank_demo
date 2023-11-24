import 'package:flutter_redux_bank/domain/entity/auth/login_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/loginerror_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class AuthUseCase {
  late AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> invokeLoginPassword(LoginRequest request) async {
    final response = await authRepository.doLoginPassword(request);
    return response;
  }

  Future<result_type.Result<LoginResponseEntity, LoginResponseErrorEntity>> invokeCreateAccount(LoginRequest request) async {
    return await authRepository.doCreateAccount(request);
  }

  Future<void> invokeLogout() async {
    return await authRepository.doLogout();
  }

}
