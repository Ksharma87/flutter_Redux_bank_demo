import 'package:flutter/material.dart';

@immutable
class DetailsState {
  final bool isMale;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  const DetailsState(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.isMale});

  factory DetailsState.initial() {
    return const DetailsState(
        firstName: '', lastName: '', mobileNumber: '', isMale: true);
  }

  DetailsState copyWith({
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required bool isMale,
  }) {
    return DetailsState(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        isMale: isMale);
  }
}
