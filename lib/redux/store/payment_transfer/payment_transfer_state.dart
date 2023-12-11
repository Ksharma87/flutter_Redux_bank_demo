import 'package:flutter/material.dart';

@immutable
class PaymentTransferState {
  final String numberConvertText;

  const PaymentTransferState({
    this.numberConvertText = '',
  });

  factory PaymentTransferState.initial() {
    return const PaymentTransferState(
      numberConvertText: '',
    );
  }

  PaymentTransferState copyWith({
    numberConvertText = '',
  }) {
    return PaymentTransferState(
      numberConvertText: numberConvertText,
    );
  }
}
