import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_actions.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_state.dart';
import 'package:redux/redux.dart';

Reducer<BottomNavState> bottomNavStateReducer  = combineReducers<BottomNavState>([
  TypedReducer<BottomNavState, BottomTabChange>(_tabChange).call,
]);

BottomNavState _tabChange(BottomNavState bottomNavState, BottomTabChange action) {
  return bottomNavState.copyWith(
    index: action.index,
  );
}

