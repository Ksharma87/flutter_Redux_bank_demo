import 'dart:async';

import 'package:flutter_redux_bank/redux/actions.dart';

class GenderSelectAction extends Actions {
  final bool gender;

  GenderSelectAction({required this.gender});
}

class UserDetailsSubmit extends Actions {
  final bool gender;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final Completer completer;

  UserDetailsSubmit(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.gender,
      required this.completer});
}
