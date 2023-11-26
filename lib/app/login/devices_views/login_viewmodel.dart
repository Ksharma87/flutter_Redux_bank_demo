import 'dart:async';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/account_status.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
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
          final Completer<String?> completer = Completer<String?>();
          _authCalling(store, SignIn(completer, email, password), completer);
        },
        onCreateAccount: (email, password) {
          final Completer<String?> completer = Completer<String?>();
          _authCalling(
              store, CreateAccount(completer, email, password), completer);
        });
  }

  static _authCalling(
      Store<AppState> store, dynamic action, Completer<String?> completer) {
    final loading = LoadingProgressDialog();
    loading.showProgressDialog();
    store.dispatch(action);
    completer.future.then((value) => {
          loading.hideProgressDialog(),
          value == null
              ? _moveDashBoardScreen(store, action)
              : errorMessageFilters(
                  value,
                )
        });
  }

  static _moveDashBoardScreen(Store<AppState> store, dynamic action) {
    if(action is SignIn) {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.DASHBOARD, (route) => false));
    } else {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.USER_INFO, (route) => false));
    }
  }

  @override
  bool operator ==(Object other) {
    return true;
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
}
