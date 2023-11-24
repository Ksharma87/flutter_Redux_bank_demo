import 'package:flutter/material.dart';
import 'package:base/src/base/base_widget.dart';
import 'package:flutter_redux_bank/app/login/login_controller.dart';

class LoginPage extends BaseWidget {
  final String authType;

  const LoginPage({super.key, required this.authType});

  @override
  State<LoginPage> createState() => LoginController();
}
