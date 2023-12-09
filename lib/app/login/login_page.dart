import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/login/login_controller.dart';

class LoginPage extends BaseStatelessWidget {
  final String authType;

  LoginPage({super.key, required this.authType});

  late final LoginController controller = LoginController(authType: authType);

  @override
  Widget build(BuildContext context) {
    return controller.build(context);
  }
}
