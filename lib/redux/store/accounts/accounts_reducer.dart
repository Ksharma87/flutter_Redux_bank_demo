import 'package:flutter_redux_bank/redux/store/accounts/accounts_actions.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_state.dart';
import 'package:redux/redux.dart';

Reducer<AccountsState> accountStateReducer = combineReducers<AccountsState>([
  TypedReducer<AccountsState, GetAccountsDetails>(_getUserProfile).call,
  TypedReducer<AccountsState, AccountsDetailsLoaded>(_getUserProfileLoaded)
      .call,
  TypedReducer<AccountsState, InitialAccountsDetailsAction>(_getUserAccountRefresh)
      .call,
]);

AccountsState _getUserProfile(
    AccountsState accountsState, GetAccountsDetails action) {
  return accountsState.copyWith(balance: '', bankAccountNumber: '', cardNumber: '', displayName: '', isLoading: false);
}

AccountsState _getUserProfileLoaded(
    AccountsState accountsState, AccountsDetailsLoaded action) {
  return accountsState.copyWith(
      balance: action.balance, bankAccountNumber: action.bankAccountNumber, cardNumber: action.cardNumber, displayName: action.displayName, isLoading: false);
}

AccountsState _getUserAccountRefresh(
    AccountsState accountsState, InitialAccountsDetailsAction action) {
  return accountsState.copyWith(
      bankAccountNumber: '', cardNumber: '', balance: '', displayName: '', isLoading: false);
}
