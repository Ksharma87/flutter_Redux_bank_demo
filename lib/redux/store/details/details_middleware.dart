import 'package:flutter_redux_bank/common/gender_type.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> detailsStoreAuthMiddleware() {
  final updateDetails = _updateDetailsRequest();
  final updateIdentity = _updateIdentityRequest();
  final uniqueMobileNumber = _uniqueMobileNumber();
  return [
    TypedMiddleware<AppState, UserDetailsSubmit>(updateDetails).call,
    TypedMiddleware<AppState, UserUniqueMobileNumber>(uniqueMobileNumber).call,
    TypedMiddleware<AppState, UserIdentity>(updateIdentity).call,
  ];
}

Middleware<AppState> _updateDetailsRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserDetailsSubmit userDetailsSubmit = action;
    String firstName = userDetailsSubmit.firstName;
    String lastName = userDetailsSubmit.lastName;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? email =
        preferencesManager.getPreferencesValue(PreferencesContents.emailId)!;
    profileUseCase
        .invokeUpdateProfile(
            email,
            firstName,
            lastName,
            userDetailsSubmit.mobileNumber,
            userDetailsSubmit.gender
                ? GenderType.MALE.name
                : GenderType.FEMALE.name)
        .then((data) {
      userDetailsSubmit.completer.complete(data);
    });
    next(action);
  };
}

Middleware<AppState> _uniqueMobileNumber() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserUniqueMobileNumber uniqueMobileNumber = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    profileUseCase
        .invokeUniqueMobileNumber(uniqueMobileNumber.mobileNumber)
        .then((value) => {uniqueMobileNumber.completer.complete(value)});

    next(action);
  };
}

Middleware<AppState> _updateIdentityRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserIdentity userIdentity = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    PreferencesManager preferencesManager = getIt<PreferencesManager>();
    String? email =
        preferencesManager.getPreferencesValue(PreferencesContents.emailId)!;
    String? uid =
        preferencesManager.getPreferencesValue(PreferencesContents.userUid);
    profileUseCase
        .invokeUpdateIdentity(email, userIdentity.mobileNumber, uid!)
        .then((value) => {userIdentity.completer.complete(value)});

    next(action);
  };
}
