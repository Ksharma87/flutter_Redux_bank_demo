import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
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

  return [
    TypedMiddleware<AppState, GetAccountsDetails>(getUsrAccountDetails).call,
  ];
}

Middleware<AppState> _getAccountDetailsRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {

    LoadingProgressDialog progressDialog = LoadingProgressDialog();
    progressDialog.showProgressDialog();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? uid =
        preferencesManager.getPreferencesValue(PreferencesContents.userUid)!;
    String? token =
        preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;

    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    Future<BankAccountResponseEntity> bankResponse =
        accountsUseCase.invokeBankAccountDetails(uid);

    if (store.state.profileState.firstName.isEmpty) {
      ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
      Future<Result<ProfileResponseEntity, ProfileResponseErrorEntity>>
          profileResponse = profileUseCase.invokeGetUserProfile(token, uid);
      Future.wait([profileResponse, bankResponse])
          .then((result) => {
             progressDialog.hideProgressDialog(),
            _handleResponse(result)
          });
    } else {
      Future.wait([bankResponse]).then((result) => {
         progressDialog.hideProgressDialog(),
        _handleResponseAccount(result)
      });
    }

    next(action);
  };
}

void _handleResponseAccount(List<Object> result) {
  String cardNo = "41".generateDebitCardRandom();
  BankAccountResponseEntity responseEntityBank =
      (result[0] as BankAccountResponseEntity);

  store.dispatch(AccountsDetailsLoaded(
      balance: responseEntityBank.balance,
      bankAccountNumber: responseEntityBank.bankAccountNumber,
      cardNumber: cardNo,
      displayName:
          ("${store.state.profileState.firstName} ${store.state.profileState.lastName}")
              .toUpperCase()));
}

void _handleResponse(List<Object> result) {
  String cardNo = "41".generateDebitCardRandom();
  ProfileResponseEntity responseEntityProfile =
      (result[0] as Success<ProfileResponseEntity, ProfileResponseErrorEntity>)
          .tryGetSuccess();
  BankAccountResponseEntity responseEntityBank =
      (result[1] as BankAccountResponseEntity);

  store.dispatch(GetUserProfileLoaded(
      email: responseEntityProfile.email,
      firstName: responseEntityProfile.firstName,
      lastName: responseEntityProfile.lastName,
      gender: responseEntityProfile.gender,
      mobileNumber: responseEntityProfile.mobileNumber,
      balance: responseEntityBank.balance));

  store.dispatch(AccountsDetailsLoaded(
      balance: responseEntityBank.balance,
      bankAccountNumber: responseEntityBank.bankAccountNumber,
      cardNumber: cardNo,
      displayName:
          ("${responseEntityProfile.firstName} ${responseEntityProfile.lastName}")
              .toUpperCase()));
}
