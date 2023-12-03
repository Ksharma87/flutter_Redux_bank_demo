import 'dart:async';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/account_status.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_actions.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final AuthState authState;
  final Function onLogin;
  final Function onCreateAccount;

  LoginViewModel(
      {required this.authState,
      required this.onLogin,
      required this.onCreateAccount});

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
        authState: store.state.authState,
        onLogin: (email, password) {
          final Completer completer = Completer();
          _authResponseHandle(
              store, SignIn(completer, email, password), completer);
        },
        onCreateAccount: (email, password) {
          final Completer completer = Completer();
          _authResponseHandle(
              store, CreateAccount(completer, email, password), completer);
        });
  }

  static _authResponseHandle(
      Store<AppState> store, dynamic action, Completer completer) {
    store.dispatch(action);
    completer.future.then((value) => {
      value is LoginResponseEntity
              ? {saveUserDetails(value), _moveDashBoardScreen(store, action)}
              : errorMessageFilters(value)
        });
  }

  static _moveDashBoardScreen(Store<AppState> store, dynamic action) {
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? displayName =
        preferencesManager.getPreferencesValue(PreferencesContents.displayName);

    if (action is SignIn && displayName != null && displayName.isNotEmpty) {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.DASHBOARD, (route) => false));
    } else {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.USER_INFO, (route) => false));
    }
  }

  static saveUserDetails(LoginResponseEntity response) {
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    preferencesManager.setPreferencesValue(
        PreferencesContents.userUid, response.localId);
    preferencesManager.setPreferencesValue(
        PreferencesContents.loginToken, response.idToken);
    preferencesManager.setPreferencesValue(
        PreferencesContents.emailId, response.email);
  }

  static errorMessageFilters(String value) {
    if (value.compareTo(AccountApiStatus.EMAIL_NOT_FOUND.name.toString()) ==
        0) {
      ToastView.displaySnackBar("Account does not exist.");
    } else if ((value.compareTo(
                AccountApiStatus.INVALID_PASSWORD.name.toString())) ==
            0 ||
        (value.compareTo(AccountApiStatus.INVALID_PASSWORD.name.toString())) ==
            0) {
      ToastView.displaySnackBar("user credentials mismatch");
    } else if (value.compareTo(AccountApiStatus.EMAIL_EXISTS.name.toString()) ==
        0) {
      ToastView.displaySnackBar("Account already exist.");
    }
  }

  @override
  bool operator ==(Object other) {
    return true;
  }
}
