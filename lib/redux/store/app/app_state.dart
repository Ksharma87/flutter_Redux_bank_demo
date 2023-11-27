import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final DetailsState detailsState;

  const AppState({required this.authState, required this.detailsState});

  factory AppState.initial() => AppState(authState: AuthState.initial(), detailsState: DetailsState.initial());

  AppState copyWith({required AuthState authState, required DetailsState detailsState}) {
    return AppState(
        authState: authState,
        detailsState: detailsState
    );
  }
}
