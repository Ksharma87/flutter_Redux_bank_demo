import 'package:flutter_redux_bank/redux/actions.dart';

class GetAccountsDetails extends Actions {
  final String loginUserUid;
  final String token;
  GetAccountsDetails({required this.loginUserUid, required this.token});
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

class InitialAccountsDetailsAction extends Actions {
  InitialAccountsDetailsAction();
}
