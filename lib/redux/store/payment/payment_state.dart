import 'package:flutter/material.dart';

@immutable
class PaymentState {
  final String paymentUid;
  final String isMale;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;

  const PaymentState(
      {required this.paymentUid,
      this.firstName = '',
      this.lastName = '',
      this.mobileNumber = '',
      this.isMale = '',
      this.email = ''});

  factory PaymentState.initial() {
    return const PaymentState(
        paymentUid: '',
        firstName: '',
        lastName: '',
        mobileNumber: '',
        isMale: '',
        email: '');
  }

  PaymentState copyWith(
      {required String paymentUid,
      String firstName = '',
      String lastName = '',
      String mobileNumber = '',
      String isMale = '',
      String email = ''}) {
    return PaymentState(
        paymentUid: paymentUid,
        firstName: firstName,
        lastName: lastName,
        isMale: isMale,
        email: email,
        mobileNumber: mobileNumber);
  }
}
