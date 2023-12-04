import 'package:flutter_redux_bank/redux/store/auth/auth_actions.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authStateReducer = combineReducers<AuthState>([

  TypedReducer<AuthState, AuthLoggedIn>(_loggedIn).call,
  TypedReducer<AuthState, AuthError>(_loggedError).call,
  TypedReducer<AuthState, AuthLoggedOut>(_loggedOut).call,
  TypedReducer<AuthState, AuthInitialization>(_init).call,

]);

AuthState _loggedIn(AuthState authState, AuthLoggedIn action) {
  return authState.copyWith(
    token: action.token,
    uid: action.uid,
    isEmailLinked: action.isEmailLinked,
    isLoading: false, errorMsg: '',
  );
}

AuthState _loggedOut(AuthState authState, AuthLoggedOut action) {
  return authState.copyWith(
    token: '',
    uid: '',
    isEmailLinked: false,
    isLoading: false, errorMsg: '',
  );
}

AuthState _loggedError(AuthState authState, AuthError action) {
  return authState.copyWith(
    token: '',
    uid: '',
    isEmailLinked: false,
    isLoading: false, errorMsg: action.error!,
  );
}


AuthState _init(AuthState authState, AuthInitialization action) {
  return authState.copyWith(
    token: '',
    uid: '',
    isEmailLinked: false,
    isLoading: false, errorMsg: '',
  );
}