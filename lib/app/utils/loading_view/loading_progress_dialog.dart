import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_view.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class LoadingProgressDialog {
  bool isLoading = false;

  void showProgressDialog() {
    showDialog(
        barrierColor: Colors.black38,
        barrierDismissible: false,
        context: NavigatorHolder.navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          isLoading = true;
          return const LoadingProgressView();
        });
  }

  void hideProgressDialog() {
    if (isLoading) {
      isLoading = false;
      Navigator.pop(NavigatorHolder.navigatorKey.currentState!.context);
    }
  }
}
