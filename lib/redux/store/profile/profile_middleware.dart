import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
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
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? idToken =
        preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;
    GetUserProfile profileAction = action;
    final profileInfo =
        profileUseCase.invokeGetUserProfile(idToken, profileAction.uid);
    Future.wait([profileInfo]).then((result) => {
          (result[0]).whenSuccess((success) => {
                store.dispatch(GetUserProfileLoaded(
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
