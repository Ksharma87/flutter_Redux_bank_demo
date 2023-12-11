import 'dart:async';
import 'package:flutter_redux_bank/redux/actions.dart';

class GenderSelectionAction extends Actions {
  final bool gender;

  GenderSelectionAction({required this.gender});
}

class UserDetailsSubmit extends Actions {
  final String email;
  final bool gender;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final Completer completer;

  UserDetailsSubmit(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.gender,
      required this.completer});
}

class DetailsStateReset extends Actions {
  DetailsStateReset();
}

class UserUniqueMobileNumberCall extends Actions {
  final String mobileNumber;

  UserUniqueMobileNumberCall({required this.mobileNumber});
}

class UserUniqueMobileNumberCallResult extends Actions {
  final bool isUniqueMobileNumber;

  UserUniqueMobileNumberCallResult({required this.isUniqueMobileNumber});
}

class UserIdentity extends Actions {
  final String email;
  final String mobileNumber;
  final String uid;
  final Completer completer;

  UserIdentity(
      {required this.email,
      required this.mobileNumber,
      required this.uid,
      required this.completer});
}

class CreateAccountsAction extends Actions {
  final String uid;
  final String balance;
  final String accountNumber;
  final Completer completer;

  CreateAccountsAction(
      {required this.uid,
      required this.balance,
      required this.accountNumber,
      required this.completer});
}

class CreateAccountsSuccessful extends Actions {
  final String uid;

  CreateAccountsSuccessful({required this.uid});
}

class CreateAccountsError extends Actions {
  CreateAccountsError();
}
