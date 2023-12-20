import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final Store<AppState> _store;

  HomeViewModel(this._store);

  void login() {
    _store.dispatch(NavigateToAction.push(AppRouter.LOGIN_PAGE,
        arguments: AuthType.LOGIN.name.toString()));
  }

  void createAccount() {
    _store.dispatch(NavigateToAction.push(AppRouter.LOGIN_PAGE,
        arguments: AuthType.CREATE_ACCOUNT.name.toString()));
  }
}
