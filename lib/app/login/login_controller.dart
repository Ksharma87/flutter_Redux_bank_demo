import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/login/devices_views/login_widget.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      leading: IconButton(
        key: const Key(ViewKeysConfig.appBarBackArrowKey),
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        iconSize: 30.0,
        onPressed: () {
          Navigator.pop(NavigatorHolder.navigatorKey.currentContext!);
        },
      ),
      backgroundColor: ColorsTheme.primaryColor,
      toolbarHeight: 60.h,
      title: Text(title,
          style: TextStyle(
              fontFamily: FontType.fontRobotoRegular,
              fontSize: 20.sp,
              fontWeight: FontWeight.w100,
              color: Colors.white)),
    );
  }
}
