import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/user_details/devices_views/user_details_widget.dart';
import 'package:flutter_redux_bank/app/user_details/user_details_page.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsController extends BaseStatelessScreen<UserDetailsPage>  {

  @override
  Widget body(BoxConstraints constraints) {
    return UserDetailsWidget(boxConstraints: constraints);
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
        AppLocalization.localizations!.details;
    return AppBar(
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
