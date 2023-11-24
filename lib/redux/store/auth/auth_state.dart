import 'package:flutter/material.dart';

@immutable
class AuthState {

  final String token;
  final bool hasToken;
  final bool isLoading;
  final String errorMsg;

  const AuthState(
      { required this.token, required this.hasToken, required this.isLoading, required this.errorMsg});

  factory AuthState.initial() {
    return const AuthState(
      token: "",
      hasToken: false,
      isLoading: false,
      errorMsg: ""
    );
  }

  AuthState copyWith({
    required String token,
    required bool hasToken,
    required bool isLoading,
    required String errorMsg

  }) {
    return AuthState(
      token: token ?? this.token,
      hasToken: hasToken ?? this.hasToken,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg
    );
  }

  @override
  int get hashCode =>
      token.hashCode ^
      hasToken.hashCode ^
      isLoading.hashCode;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthState &&
              runtimeType == other.runtimeType &&
              token == other.token &&
              hasToken == other.hasToken &&
              isLoading == other.isLoading;


  @override
  String toString() {
    return 'AuthState{token: $token, hasToken: $hasToken, isLoading: $isLoading}';
  }
}