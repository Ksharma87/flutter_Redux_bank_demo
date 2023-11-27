import 'package:flutter/material.dart';
import 'package:base/src/base/base_stateful_widget.dart';
import 'package:flutter_redux_bank/app/login/login_controller.dart';

class LoginPage extends BaseStatefulWidget {
  final String authType;

  const LoginPage({super.key, required this.authType});

  @override
  State<LoginPage> createState() => LoginController();
}
