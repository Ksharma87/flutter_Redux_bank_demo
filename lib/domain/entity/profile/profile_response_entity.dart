import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ProfileResponseEntity extends Equatable {
  final String mobileNumber;
  final String gender;
  final String email;
  final String firstName;
  final String lastName;

  const ProfileResponseEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.mobileNumber,
  });

  @override
  List<Object?> get props => [email, firstName, lastName, gender, mobileNumber];
}
