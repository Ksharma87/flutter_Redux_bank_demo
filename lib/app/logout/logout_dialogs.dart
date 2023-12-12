import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:injectable/injectable.dart';

@singleton
class LogoutDialogs {
  showLogout(BuildContext context, Function(bool) callback) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are You Sure for Logout ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No',
                  style: TextStyle(color: ColorsTheme.secondColor)),
              onPressed: () {
                callback(false);
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: ColorsTheme.secondColor),
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
