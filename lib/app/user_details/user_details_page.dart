import 'package:flutter/material.dart';
import 'package:base/src/base/base_stateful_widget.dart';
import 'package:flutter_redux_bank/app/user_details/user_details_controller.dart';

class UserDetailsPage extends BaseStatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => UserDetailsController();
}


