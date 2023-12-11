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
  final String token;

  GetPayeeUserProfile({required this.uid, required this.token});
}

class GetPayeeUserProfileLoaded extends Actions {
  final String email;
  final String mobileNumber;
  final String firstName;
  final String gender;
  final String lastName;
  final String balance;

  GetPayeeUserProfileLoaded({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobileNumber,
    required this.balance,
  });
}

class InitialPaymentAction extends Actions {
  final String loginUserId;
  final String payeeUserId;
  final String amount;

  InitialPaymentAction(
      {required this.loginUserId,
      required this.payeeUserId,
      required this.amount});
}

class PaymentCompletedAction extends Actions {
  PaymentCompletedAction();
}

class InitialAction extends Actions {
  InitialAction();
}
