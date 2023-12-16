import 'package:flutter/material.dart';

@immutable
class AuthState {
  final String uid;
  final String token;
  final bool isEmailLinked;
  final bool isLoading;
  final String errorMsg;

  const AuthState(
      {required this.token,
      required this.uid,
      required this.isEmailLinked,
      required this.isLoading,
      required this.errorMsg});

  factory AuthState.initial() {
    return const AuthState(
        token: "", uid: '', isEmailLinked: false, isLoading: false, errorMsg: "");
  }

  AuthState copyWith(
      {required String token,
      required String uid,
      required bool isEmailLinked,
      required bool isLoading,
      required String errorMsg}) {
    return AuthState(
        token: token,
        uid: uid,
        isEmailLinked: isEmailLinked,
        isLoading: isLoading,
        errorMsg: errorMsg);
  }

  @override
  int get hashCode => token.hashCode ^ errorMsg.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          isEmailLinked == other.isEmailLinked &&
          errorMsg == other.errorMsg &&
          isLoading == other.isLoading;

  @override
  String toString() {
    return 'AuthState{token: $token, hasToken: $isEmailLinked, isLoading: $isLoading}';
  }
}
