import 'dart:async';
import 'package:flutter_redux_bank/redux/actions.dart';

class AuthLoggedIn extends Actions {
  final String token;
  AuthLoggedIn({required this.token});
}

class AuthError extends Actions {
  final String? error;
  AuthError({required this.error});
}

class AuthLoggedOut extends Actions {}

class SignIn extends Actions {
  final Completer completer;
  final String email;
  final String password;

  SignIn(this.completer, this.email, this.password);
}

class CreateAccount extends Actions {
  final Completer completer;
  final String email;
  final String password;

  CreateAccount(this.completer, this.email, this.password);
}



