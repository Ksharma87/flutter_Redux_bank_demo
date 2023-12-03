import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_reducer.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_reducer.dart';
import 'package:flutter_redux_bank/redux/store/details/details_reducer.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_reducer.dart';


AppState appStateReducer(AppState state, dynamic action) =>
    AppState(
        authState: authStateReducer(state.authState, action),
        detailsState: detailsStateReducer(state.detailsState, action),
        bottomNavState: bottomNavStateReducer(state.bottomNavState, action),
        profileState: userProfileStateReducer(state.profileState, action)
    );
