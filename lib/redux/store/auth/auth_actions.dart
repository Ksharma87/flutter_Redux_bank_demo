import 'dart:async';
import 'package:flutter_redux_bank/redux/actions.dart';

class AuthLoggedIn extends Actions {
  final String token;
  final String emailId;
  final String uid;
  final bool isEmailLinked;
  AuthLoggedIn({required this.token, required this.emailId, required this.uid, required this.isEmailLinked});
}

class AuthError extends Actions {
  final String? error;

  AuthError({required this.error});
}

class AuthInitialization extends Actions {}
class AuthLoggedOut extends Actions {}

class SignIn extends Actions {

  final String email;
  final String password;

  SignIn(this.email, this.password);
}

class CreateAccount extends Actions {

  final String email;
  final String password;

  CreateAccount(this.email, this.password);
}
