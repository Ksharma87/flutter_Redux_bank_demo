import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/useCase/auth/auth_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/store.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreAuthMiddleware() {
  final loginRequest = _createLoginRequest();
  final createAccountRequest = _createAccountRequest();
  return [
    TypedMiddleware<AppState, SignIn>(loginRequest).call,
    TypedMiddleware<AppState, CreateAccount>(createAccountRequest).call
  ];
}

Middleware<AppState> _createLoginRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    SignIn signInAction = action;
    String email = signInAction.email;
    String pwd = signInAction.password;
    AuthUseCase authUseCase = getIt<AuthUseCase>();
    authUseCase.invokeLoginPassword(email, pwd).then((data) {
      data.whenSuccess((success) => {
            store.dispatch(AuthLoggedIn(token: success.idToken)),
            action.completer.complete(success)
          });
      data.whenError((error) => {
            store.dispatch(AuthError(error: error.errorMsg)),
            action.completer.complete(error.errorMsg)
          });
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
            store.dispatch(AuthLoggedIn(token: success.idToken)),
            action.completer.complete(success)
          });
      data.whenError((error) => {
            store.dispatch(AuthError(error: error.errorMsg)),
            action.completer.complete(error.errorMsg)
          });
    });
    next(action);
  };
}
