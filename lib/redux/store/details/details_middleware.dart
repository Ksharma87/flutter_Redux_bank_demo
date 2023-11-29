import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/useCase/auth/auth_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> detailsStoreAuthMiddleware() {
  final loginRequest = _updateDetailsRequest();
  return [
    TypedMiddleware<AppState, UserDetailsSubmit>(loginRequest).call,
  ];
}

Middleware<AppState> _updateDetailsRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserDetailsSubmit userDetailsSubmit = action;
    String firstName = userDetailsSubmit.firstName;
    String lastName = userDetailsSubmit.lastName;
    String displayName = '$firstName  $lastName';
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? token =
        preferencesManager.getPreferencesValue(PreferencesContents.loginToken)!;
    profileUseCase.invokeUpdateProfile(token, displayName, '').then((data) {

    });
    next(action);
  };
}
