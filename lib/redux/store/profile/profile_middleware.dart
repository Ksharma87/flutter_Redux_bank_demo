import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
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
    // LoadingProgressDialog dialog = LoadingProgressDialog();
    // dialog.showProgressDialog();
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? idToken =
        preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;
    String? uid =
        preferencesManager.getPreferencesValue(PreferencesContents.userUid)!;
    profileUseCase.invokeGetUserProfile(idToken, uid).then((value) => {
          value.whenError((error) => {
          //  dialog.hideProgressDialog()
          }),
          value.whenSuccess((success) => {
                //dialog.hideProgressDialog(),
                store.dispatch(GetUserProfileLoaded(
                    email: success.email,
                    firstName: success.firstName,
                    lastName: success.lastName,
                    gender: success.gender,
                    mobileNumber: success.mobileNumber))
              }),
        });
    next(action);
  };
}
