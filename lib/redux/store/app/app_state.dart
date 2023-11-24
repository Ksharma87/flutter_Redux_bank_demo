import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';

@immutable
class AppState {
  final AuthState authState;

  const AppState({required this.authState});

  factory AppState.initial() => AppState(authState: AuthState.initial());

  AppState copyWith({required AuthState authState}) {
    return AppState(
        authState: authState
    );
  }
}
