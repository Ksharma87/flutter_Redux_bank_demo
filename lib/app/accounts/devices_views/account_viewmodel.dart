import 'package:flutter_redux_bank/redux/store/accounts/store.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:redux/redux.dart';

class AccountViewModel {
  final AccountsState accountsState;

  AccountViewModel({
    required this.accountsState,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    return AccountViewModel(
      accountsState: store.state.accountsState,
    );
  }

  @override
  int get hashCode =>
      accountsState.balance.hashCode ^ accountsState.isLoading.hashCode;

  @override
  bool operator ==(Object other) {
    AccountViewModel model = (other as AccountViewModel);
    return accountsState.balance == model.accountsState.balance &&
        accountsState.isLoading == model.accountsState.isLoading;
  }
}
