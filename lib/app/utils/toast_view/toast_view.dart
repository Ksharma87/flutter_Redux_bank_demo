import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/utils/global_key_holder.dart';

class ToastView {

  static displaySnackBar(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    GlobalKeyHolder.scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
