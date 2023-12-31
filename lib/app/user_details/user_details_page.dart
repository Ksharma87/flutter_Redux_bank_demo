import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/user_details/user_details_controller.dart';

class UserDetailsPage extends BaseStatelessWidget {
  UserDetailsPage({super.key});

  final UserDetailsController _userDetailsController = UserDetailsController();

  @override
  Widget build(BuildContext context) {
    return _userDetailsController.build(context);
  }
}
