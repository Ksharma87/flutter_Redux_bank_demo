import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class AppLogo {

  static Widget logo(Color primaryColor, Color secondColor) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!.noida.substring(0,1),
                style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!.noida.substring(1),
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          color: primaryColor)))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(" ${AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!.bank}",
                      style: TextStyle(
                          fontFamily: 'Roboto Light',
                          fontSize: 50,
                          fontWeight: FontWeight.w100,
                          // light
                          fontStyle: FontStyle.normal,
                          color: secondColor))))
        ],
      ),
    );
  }

}