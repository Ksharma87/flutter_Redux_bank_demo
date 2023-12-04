import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/useCase/auth/auth_useCase.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/store.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreAuthMiddleware() {
  final loginRequest = _createLoginRequest();
  final createAccountRequest = _createAccountRequest();
  return [
    TypedMiddleware<AppState, SignIn>(loginRequest).call,
    TypedMiddleware<AppState, CreateAccount>(createAccountRequest).call,
  ];
}

Middleware<AppState> _createLoginRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    SignIn signInAction = action;
    String email = signInAction.email;
    String pwd = signInAction.password;
    AuthUseCase authUseCase = getIt<AuthUseCase>();
    Result<LoginResponseEntity, LoginResponseErrorEntity> loginResult;

    Future<Result<LoginResponseEntity, LoginResponseErrorEntity>> loginRequest =
        authUseCase.invokeLoginPassword(email, pwd);
    Future<bool> isEmailExisting = authUseCase.invokeEmailLinkedDataBase(email);

    Future.wait([loginRequest, isEmailExisting]).then((result) => {
      loginResult = result[0]
              as Result<LoginResponseEntity, LoginResponseErrorEntity>,
          loginResult.whenSuccess((success) => {
                store.dispatch(AuthLoggedIn(
                    token: success.idToken,
                    emailId: email,
                    uid: success.localId,
                    isEmailLinked: !(result[1] as bool))),
              }),
          loginResult.whenError(
              (error) => {store.dispatch(AuthError(error: error.errorMsg))})
        });
    next(action);
  };
}

Middleware<AppState> _createAccountRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    CreateAccount createAccount = action;
    String email = createAccount.email;
    String pwd = createAccount.password;
    AuthUseCase authUseCase = getIt<AuthUseCase>();
    authUseCase.invokeCreateAccount(email, pwd).then((data) {
      data.whenSuccess((success) => {
            store.dispatch(AuthLoggedIn(
                token: success.idToken,
                emailId: email,
                uid: success.localId,
                isEmailLinked: false)),
          });
      data.whenError((error) => {
            store.dispatch(AuthError(error: error.errorMsg)),
          });
    });
    next(action);
  };
}
