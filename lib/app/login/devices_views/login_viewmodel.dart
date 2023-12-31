import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/common/status/account_status.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_actions.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_actions.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
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
          _authResponseHandle(store, SignIn(email, password));
        },
        onCreateAccount: (email, password) {
          _authResponseHandle(store, CreateAccountAction(email, password));
        });
  }

  static _authResponseHandle(Store<AppState> store, dynamic action) {
    store.dispatch(action);
  }

  moveDashBoardScreen(Store store, bool moveDashBoard) {

    PreferencesManager preferencesManager = PreferencesManager();
    preferencesManager.setPreferencesValue(PreferencesContents.balance, '');
    store.dispatch(InitUserProfile());
    store.dispatch(InitialAccountsDetailsAction());

    if (moveDashBoard) {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.DASHBOARD, (route) => false));
    } else {
      store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
          AppRouter.USER_INFO, (route) => false));
    }
  }

  saveUserDetails(String email, String idToken, String uid) {
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    preferencesManager.setPreferencesValue(PreferencesContents.userUid, uid);
    preferencesManager.setPreferencesValue(
        PreferencesContents.loginToken, idToken);
    preferencesManager.setPreferencesValue(PreferencesContents.emailId, email);
  }

  errorMessageFilters(String value) {
    if (value.compareTo(AccountApiStatus.EMAIL_NOT_FOUND.name.toString()) ==
        0) {
      ToastView.displaySnackBar(AppLocalization.localizations!.account_not_exist);
    } else if ((value.compareTo(
                AccountApiStatus.INVALID_PASSWORD.name.toString())) ==
            0 ||
        (value.compareTo(AccountApiStatus.INVALID_PASSWORD.name.toString())) ==
            0 ||
        (value.compareTo(
                AccountApiStatus.INVALID_LOGIN_CREDENTIALS.name.toString())) ==
            0) {
      ToastView.displaySnackBar(AppLocalization.localizations!.password_mismatch);
    } else if (value.compareTo(AccountApiStatus.EMAIL_EXISTS.name.toString()) ==
        0) {
      ToastView.displaySnackBar(AppLocalization.localizations!.account_already_exist);
    }
  }

  @override
  int get hashCode => authState.token.hashCode ^ authState.errorMsg.hashCode;

  @override
  bool operator ==(Object other) {
    LoginViewModel model = (other as LoginViewModel);
    return authState.token == model.authState.token &&
        authState.errorMsg == model.authState.errorMsg;
  }
}
