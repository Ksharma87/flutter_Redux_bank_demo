import 'package:flutter/material.dart';

@immutable
class AccountsState {
  final String balance;
  final String bankAccountNumber;
  final String cardNumber;
  final String displayName;
  final bool isLoading;

  const AccountsState(
      {required this.bankAccountNumber,
      required this.cardNumber,
      required this.balance,
      required this.displayName,
      required this.isLoading});

  factory AccountsState.initial() {
    return const AccountsState(
        bankAccountNumber: '', cardNumber: '', balance: '', displayName: '', isLoading: false);
  }

  AccountsState copyWith(
      {required String balance,
      required String bankAccountNumber,
      required String cardNumber,
      required String displayName, required bool isLoading}) {
    return AccountsState(
        bankAccountNumber: bankAccountNumber,
        cardNumber: cardNumber,
        balance: balance,
        displayName: displayName, isLoading: isLoading);
  }
}
