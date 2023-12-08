import 'dart:async';

import 'package:flutter_redux_bank/redux/actions.dart';

class GetAccountsDetails extends Actions {
  GetAccountsDetails();
}

class AccountsDetailsLoaded extends Actions {
  final String balance;
  final String bankAccountNumber;
  final String cardNumber;
  final String displayName;

  AccountsDetailsLoaded(
      {required this.balance,
      required this.bankAccountNumber,
      required this.cardNumber,
      required this.displayName});
}

class CreateAccountsAction extends Actions {
  final Completer completer;
  final String uid;
  final String balance;
  final String accountNumber;
  CreateAccountsAction(
      {required this.completer,
      required this.uid,
      required this.balance,
      required this.accountNumber,
      });
}

class CreateAccountsSuccessful extends Actions {
  final String uid;

  CreateAccountsSuccessful({required this.uid});
}

class CreateAccountsError extends Actions {
  CreateAccountsError();
}
