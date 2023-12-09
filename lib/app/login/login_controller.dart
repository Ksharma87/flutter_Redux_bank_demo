import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/login/devices_views/login_widget.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';

class LoginController extends BaseStatelessScreen<LoginPage> {
  String authType;

  LoginController({required this.authType});

  @override
  Widget body(BoxConstraints constraints) {
    return LoginWidget(
      authType: authType,
      boxConstraints: constraints,
    );
  }

  @override
  bool isFullScreen() {
    return true;
  }

  @override
  Color rootBackgroundColor() {
    return Colors.white;
  }

  @override
  PreferredSizeWidget? appBar() {
    String title =
        "${AppLocalization.localizations!.noida} ${AppLocalization.localizations!.bank}";
    return AppBar(
      backgroundColor: ColorsTheme.primaryColor,
      toolbarHeight: 60,
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'Roboto Regular',
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: Colors.white)),
    );
  }
}
