import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:injectable/injectable.dart';

@singleton
class LogoutDialogs {
  showLogout(BuildContext context, Function(bool) callback) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalization.localizations!.logout),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalization.localizations!.logoutDesc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalization.localizations!.no,
                  style: const TextStyle(color: ColorsTheme.secondColor)),
              onPressed: () {
                callback(false);
              },
            ),
            TextButton(
              child: Text(
                AppLocalization.localizations!.yes,
                style: const TextStyle(color: ColorsTheme.secondColor),
              ),
              onPressed: () {
                callback(true);
              },
            ),
          ],
        );
      },
    );
  }
}
