import 'package:flutter/material.dart';

@immutable
class ProfileState {
  final String isMale;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  const ProfileState(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.isMale});

  factory ProfileState.initial() {
    return const ProfileState(
        firstName: '', lastName: '', mobileNumber: '', isMale: '');
  }

  ProfileState copyWith({
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String isMale,
  }) {
    return ProfileState(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        isMale: isMale);
  }
}
