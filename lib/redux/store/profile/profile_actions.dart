import 'package:flutter_redux_bank/redux/actions.dart';

class GetUserProfile extends Actions {
  GetUserProfile();
}

class GetUserProfileLoaded extends Actions {
  final String email;
  final String mobileNumber;
  final String firstName;
  final String gender;
  final String lastName;
  GetUserProfileLoaded({required this.email, required this.firstName,
    required this.lastName, required this.gender, required this.mobileNumber});
}