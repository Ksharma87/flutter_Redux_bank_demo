import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_view.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadingProgressDialog {

  showProgressDialog() {
    showDialog(
        barrierColor: Colors.black38,
        barrierDismissible: false,
        context: NavigatorHolder.navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return const LoadingProgressView();
        });
  }

  hideProgressDialog() {
    Navigator.pop(NavigatorHolder.navigatorKey.currentState!.context);
  }
}
