import 'package:equatable/equatable.dart';

class BankAccountResponseEntity extends Equatable {
  String balance;

  String bankAccountNumber;

  BankAccountResponseEntity({
    required this.balance,
    required this.bankAccountNumber,
  });

  @override
  List<Object?> get props => [
        balance,
        bankAccountNumber,
      ];
}
