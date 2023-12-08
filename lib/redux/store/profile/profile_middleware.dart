import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> profileStoreAuthMiddleware() {
  final getUsrProfileDetails = _getUserProfileRequest();
  return [
    TypedMiddleware<AppState, GetUserProfile>(getUsrProfileDetails).call,
  ];
}

Middleware<AppState> _getUserProfileRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? idToken =
        preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;
    GetUserProfile profileAction = action;
    final accountInfo = accountsUseCase.invokeBankAccountDetails(profileAction.uid);
    final profileInfo = profileUseCase.invokeGetUserProfile(idToken, profileAction.uid);
    print(profileAction.uid);
    accountInfo.then((value) => {
      debugPrint(value.balance)
    });
    Future.wait([accountInfo, profileInfo]).then((result) => {
          (result[1]
                  as Result<ProfileResponseEntity, ProfileResponseErrorEntity>)
              .whenSuccess((success) => {
                    store.dispatch(GetUserProfileLoaded(
                        email: success.email,
                        firstName: success.firstName,
                        lastName: success.lastName,
                        gender: success.gender,
                        mobileNumber: success.mobileNumber,
                        balance:
                            (result[0] as BankAccountResponseEntity).balance))
                  }),
        });

   // next(action);
  };
}
