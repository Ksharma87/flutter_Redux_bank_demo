import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:redux/redux.dart';

Reducer<DetailsState> detailsStateReducer = combineReducers<DetailsState>([
  TypedReducer<DetailsState, GenderSelectAction>(_genderSelected).call,
]);

DetailsState _genderSelected(
    DetailsState detailsState, GenderSelectAction action) {
  return detailsState.copyWith(
    isMale: action.gender,
  );
}
