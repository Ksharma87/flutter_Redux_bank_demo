import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final DetailsState detailsState;
  final BottomNavState bottomNavState;
  final ProfileState profileState;

  const AppState(
      {required this.authState,
      required this.detailsState,
      required this.bottomNavState,
      required this.profileState});

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      detailsState: DetailsState.initial(),
      bottomNavState: BottomNavState.initial(),
      profileState: ProfileState.initial());

  AppState copyWith(
      {required AuthState authState,
      required DetailsState detailsState,
      required BottomNavState bottomNavState,
      required ProfileState profileState}) {
    return AppState(
        authState: authState,
        detailsState: detailsState,
        bottomNavState: bottomNavState,
        profileState: profileState);
  }
}
