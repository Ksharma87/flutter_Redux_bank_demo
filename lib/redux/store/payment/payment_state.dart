import 'package:flutter/material.dart';

@immutable
class PaymentState {
  final String paymentUid;
  final String isMale;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final bool isPaymentDone;
  final String numberConvertText;
  final bool hasData;

  const PaymentState(
      {required this.paymentUid,
      this.firstName = '',
      this.lastName = '',
      this.mobileNumber = '',
      this.isMale = '',
      this.email = '',
      this.isPaymentDone = false,
      this.numberConvertText = '',
      this.hasData = false});

  factory PaymentState.initial() {
    return const PaymentState(
        paymentUid: '',
        firstName: '',
        lastName: '',
        mobileNumber: '',
        isMale: '',
        email: '',
        isPaymentDone: false,
        numberConvertText: '',
        hasData: false);
  }

  PaymentState copyWith(
      {required String paymentUid,
      String firstName = '',
      String lastName = '',
      String mobileNumber = '',
      String isMale = '',
      String email = '',
      isPaymentDone = false,
      numberConvertText = '',
      hasData = false}) {
    return PaymentState(
        paymentUid: paymentUid,
        firstName: firstName,
        lastName: lastName,
        isMale: isMale,
        email: email,
        mobileNumber: mobileNumber,
        isPaymentDone: isPaymentDone,
        numberConvertText: numberConvertText,
        hasData: hasData);
  }
}
