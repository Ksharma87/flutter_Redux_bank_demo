import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';
import 'package:redux/redux.dart';

Reducer<ProfileState> userProfileStateReducer = combineReducers<ProfileState>([
  TypedReducer<ProfileState, GetUserProfile>(_getUserProfile).call,
  TypedReducer<ProfileState, GetUserProfileLoaded>(_getUserProfileLoaded).call,
]);

ProfileState _getUserProfile(
    ProfileState profileState, GetUserProfile action) {
  return profileState.copyWith(
    firstName: '',
    lastName: '',
    mobileNumber: '',
    isMale: '',
  );
}

ProfileState _getUserProfileLoaded(
    ProfileState profileState, GetUserProfileLoaded action) {
  return profileState.copyWith(
    firstName: action.firstName,
    lastName: action.lastName,
    mobileNumber: action.mobileNumber,
    isMale: action.gender,
  );
}

