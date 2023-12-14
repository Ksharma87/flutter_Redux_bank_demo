import 'package:flutter/cupertino.dart';
import 'logout_dialogs.dart';

class LogoutManager {
  static logoutCall(BuildContext context) {
    LogoutDialogs().showLogout(
        context,
        (isLogout) => {
              if (isLogout)
                {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                  })
                }
              else
                {Navigator.pop(context)}
            });
  }
}
