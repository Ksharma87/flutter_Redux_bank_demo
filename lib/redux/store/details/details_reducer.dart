import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:redux/redux.dart';

Reducer<DetailsState> detailsStateReducer = combineReducers<DetailsState>([
  TypedReducer<DetailsState, GenderSelectionAction>(_genderSelected).call,
  TypedReducer<DetailsState, DetailsStateReset>(_storeReset).call,
  TypedReducer<DetailsState, UserUniqueMobileNumberCallResult>(
          _userUniqueMobileNumberCallResult)
      .call,
]);

DetailsState _genderSelected(
    DetailsState detailsState, GenderSelectionAction action) {
  return detailsState.copyWith(
      isApiCall: false, isMale: action.gender, isUniqueMobileNumber: false);
}

DetailsState _userUniqueMobileNumberCallResult(
    DetailsState detailsState, UserUniqueMobileNumberCallResult action) {
  return detailsState.copyWith(
      isApiCall: true,
      isMale: store.state.detailsState.isMale,
      isUniqueMobileNumber: action.isUniqueMobileNumber);
}

DetailsState _storeReset(DetailsState detailsState, DetailsStateReset action) {
  return detailsState.copyWith(
      isApiCall: false,
      isMale: store.state.detailsState.isMale,
      isUniqueMobileNumber: false);
}
