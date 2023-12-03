import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:redux/redux.dart';

Reducer<DetailsState> detailsStateReducer = combineReducers<DetailsState>([
  TypedReducer<DetailsState, GenderSelectAction>(_genderSelected).call,
  TypedReducer<DetailsState, UserUniqueMobileNumberVerify>(
          _userUniqueMobileNumberVerify)
      .call,
  TypedReducer<DetailsState, UserUniqueMobileNumberExist>(
          _userUniqueMobileNumberExist)
      .call,
  TypedReducer<DetailsState, UserDetailsSubmit>(_userDetailsSubmit).call,
]);

DetailsState _genderSelected(
    DetailsState detailsState, GenderSelectAction action) {
  return detailsState.copyWith(
    firstName: '',
    lastName: '',
    mobileNumber: '',
    isMale: action.gender,
  );
}

DetailsState _userUniqueMobileNumberExist(
    DetailsState detailsState, UserUniqueMobileNumberExist action) {
  return detailsState.copyWith(
    firstName: '',
    lastName: '',
    mobileNumber: '',
    isMale: true,
  );
}

DetailsState _userUniqueMobileNumberVerify(
    DetailsState detailsState, UserUniqueMobileNumberVerify action) {
  return detailsState.copyWith(
    firstName: '',
    lastName: '',
    mobileNumber: '',
    isMale: true,
  );
}

DetailsState _userDetailsSubmit(
    DetailsState detailsState, UserDetailsSubmit action) {
  return detailsState.copyWith(
    firstName: action.firstName,
    lastName: action.lastName,
    mobileNumber: action.mobileNumber,
    isMale: action.gender,
  );
}
