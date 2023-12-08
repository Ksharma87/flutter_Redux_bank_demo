import 'package:flutter_redux_bank/redux/actions.dart';

class GetUserProfile extends Actions {
  final String uid;
  GetUserProfile({required this.uid});
}

class GetUserProfileLoaded extends Actions {
  final String email;
  final String mobileNumber;
  final String firstName;
  final String gender;
  final String lastName;
  final String balance;
  GetUserProfileLoaded({required this.email, required this.firstName,
    required this.lastName, required this.gender, required this.mobileNumber, required this.balance,});
}

class InitUserProfile extends Actions {
  InitUserProfile();
}