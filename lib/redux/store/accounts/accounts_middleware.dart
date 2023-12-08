import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_bank/common/money_format.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_actions.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> accountStoreAuthMiddleware() {
  final getUsrAccountDetails = _getAccountDetailsRequest();
  final crateBankAccount = _createBankAccount();
  return [
    TypedMiddleware<AppState, GetAccountsDetails>(getUsrAccountDetails).call,
    TypedMiddleware<AppState, CreateAccountsAction>(crateBankAccount).call,
  ];
}

Middleware<AppState> _createBankAccount() {
  return (Store<AppState> store, action, NextDispatcher next) {
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? uid =
    preferencesManager.getPreferencesValue(PreferencesContents.userUid)!;
    CreateAccountsAction createAccountsAction = action;
    String balance = createAccountsAction.balance;
    String accountNumber = createAccountsAction.accountNumber;
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    accountsUseCase
        .invokeCreateBankAccount(accountNumber, balance)
        .then((value) => {createAccountsAction.completer.complete()});

    next(action);
  };
}

Middleware<AppState> _getAccountDetailsRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? uid =
    preferencesManager.getPreferencesValue(PreferencesContents.userUid)!;
    String? token =
    preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;

    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();

    Future<Result<ProfileResponseEntity,
        ProfileResponseErrorEntity>> profileResponse = profileUseCase
        .invokeGetUserProfile(token, uid);
    Future<BankAccountResponseEntity> bankResponse = accountsUseCase
        .invokeBankAccountDetails(uid);

    Future.wait([profileResponse, bankResponse]).then((result) =>
    {
      _handleResponse(result)
    });
    next(action);
  };
}

 void _handleResponse(List<Object> result) {
   String cardNo = "41".generateDebitCardRandom();
   ProfileResponseEntity responseEntityProfile = (result[0] as Success<ProfileResponseEntity, ProfileResponseErrorEntity>).tryGetSuccess();
   BankAccountResponseEntity responseEntityBank = (result[1] as BankAccountResponseEntity);
   store.dispatch(AccountsDetailsLoaded(
       balance: responseEntityBank.balance, bankAccountNumber: responseEntityBank.bankAccountNumber,
       cardNumber: cardNo, displayName: ("${responseEntityProfile.firstName} ${responseEntityProfile.lastName}").toUpperCase()));
 }
