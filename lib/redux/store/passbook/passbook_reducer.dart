import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_actions.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_state.dart';
import 'package:redux/redux.dart';

Reducer<PassbookState> passbookStateReducer = combineReducers<PassbookState>([
  TypedReducer<PassbookState, InitPassbook>(_initProfileState).call,
  TypedReducer<PassbookState, PassbookLoaded>(_getUserProfileLoaded).call,
  TypedReducer<PassbookState, GetPassBookUserDetailsLoaded>(_getPassbookUserLoaded).call,
]);

PassbookState _getUserProfileLoaded(
    PassbookState passbookState, PassbookLoaded action) {
  return passbookState.copyWith(action.pList, action.isLoaded);
}

PassbookState _getPassbookUserLoaded(
    PassbookState passbookState, GetPassBookUserDetailsLoaded action) {
  return passbookState.copyWith(action.pList, true, isUserPassBookLoaded: true);
}

PassbookState _initProfileState(PassbookState passbookState, InitPassbook action) {
  return passbookState.copyWith([], false);
}
