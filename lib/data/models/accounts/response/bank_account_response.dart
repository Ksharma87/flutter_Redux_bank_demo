import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';

class BankAccountResponse extends BankAccountResponseEntity {
  BankAccountResponse({
    required String balance,
    required String bankAccountNumber,

  }) : super(
          balance: balance,
          bankAccountNumber: bankAccountNumber,

        ) {
    _balance = balance;
    _bankAccountNumber = bankAccountNumber;

  }

  factory BankAccountResponse.fromJson(dynamic json) {
    String? _balance = json['balance'];
    String? _bankAccountNumber = json['bankAccountNumber'];

    return BankAccountResponse(
      balance: _balance!,
        bankAccountNumber: _bankAccountNumber!,
        );
  }

  late String _balance;
  late String _bankAccountNumber;

  @override
  String get balance => _balance;

  @override
  String get bankAccountNumber => _bankAccountNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = _balance;
    map['bankAccountNumber'] = _bankAccountNumber;
    return map;
  }
}
