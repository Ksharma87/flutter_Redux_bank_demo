import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo {
  static Widget logo(Color primaryColor, Color secondColor) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Flexible(
              flex: 3,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    AppLocalizations.of(
                            NavigatorHolder.navigatorKey.currentContext!)!
                        .noida
                        .substring(0, 1),
                    style: TextStyle(
                        fontSize: 80.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ))),
          Flexible(
               flex: 3,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                          AppLocalizations.of(
                                  NavigatorHolder.navigatorKey.currentContext!)!
                              .noida
                              .substring(1),
                          style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryColor))))),
          Flexible(
              flex: 4,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                          AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!.bank,
                          style: TextStyle(
                              fontFamily: FontType.fontRobotoLight,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w100,
                              // light
                              fontStyle: FontStyle.normal,
                              color: secondColor)))))
        ],
      ),
    );
  }
}
