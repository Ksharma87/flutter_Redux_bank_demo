import 'package:flutter_redux_bank/redux/actions.dart';

class FetchPaymentUserProfile extends Actions {
  final String mobileOrEmail;
  FetchPaymentUserProfile({required this.mobileOrEmail});
}

class FetchPaymentUserProfileSuccess extends Actions {
  final String uid;
  FetchPaymentUserProfileSuccess({required this.uid});
}

class FetchPaymentUserProfileFail extends Actions {
  FetchPaymentUserProfileFail();
}

class GetPayeeUserProfile extends Actions {
  final String uid;
  GetPayeeUserProfile({required this.uid});
}

class GetPayeeUserProfileLoaded extends Actions {
  final String email;
  final String mobileNumber;
  final String firstName;
  final String gender;
  final String lastName;
  final String balance;
  GetPayeeUserProfileLoaded({required this.email, required this.firstName,
    required this.lastName, required this.gender, required this.mobileNumber, required this.balance,});
}


class InitialAction extends Actions {
  InitialAction();
}
