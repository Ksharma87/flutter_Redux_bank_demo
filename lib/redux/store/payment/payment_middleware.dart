import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> paymentStoreAuthMiddleware() {
  return [
    TypedMiddleware<AppState, FetchPaymentUserProfile>(_fetchPaymentUser())
        .call,
    TypedMiddleware<AppState, GetPayeeUserProfile>(_getPayeeUserProfileRequest())
        .call,
  ];
}

Middleware<AppState> _getPayeeUserProfileRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? idToken =
    preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;
    GetPayeeUserProfile profileAction = action;
    final profileInfo =
    profileUseCase.invokeGetUserProfile(idToken, profileAction.uid);
    Future.wait([profileInfo]).then((result) => {
      (result[0]).whenSuccess((success) => {
        store.dispatch(GetPayeeUserProfileLoaded(
            email: success.email,
            firstName: success.firstName,
            lastName: success.lastName,
            gender: success.gender,
            mobileNumber: success.mobileNumber,
            balance: preferencesManager
                .getPreferencesValue(PreferencesContents.balance)!))
      }),
    });

    next(action);
  };
}

Middleware<AppState> _fetchPaymentUser() {
  return (Store<AppState> store, action, NextDispatcher next) {
    FetchPaymentUserProfile fetchPaymentUserProfile = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    profileUseCase
        .invokeUniqueMobileNumberOrEmail(fetchPaymentUserProfile.mobileOrEmail)
        .then((value) => {
              if (value != null)
                {store.dispatch(FetchPaymentUserProfileSuccess(uid: value))}
              else
                {store.dispatch(FetchPaymentUserProfileFail())}
            });
    next(action);
  };
}
