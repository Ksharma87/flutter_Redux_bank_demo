import 'package:flutter/material.dart';
import 'package:base/src/base/stateless/base_stateless_screen.dart';
import 'package:flutter_redux_bank/app/payment_transfer/devices_views/payment_transfer_widget.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_page.dart';
import 'package:flutter_redux_bank/app/user_details/devices_views/user_details_widget.dart';
import 'package:flutter_redux_bank/app/user_details/user_details_page.dart';
import 'package:flutter_redux_bank/common/string_extension.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';

class PaymentTransferController extends BaseStatelessScreen<PaymentTransferPage>  {

  @override
  Widget body(BoxConstraints constraints) {
    return PaymentTransferWidget(uid: 'YZ1ACz4AKQYVHutHNartcfObYSm1', boxConstraints: constraints);
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
        AppLocalization.localizations!.payment.toLowerCase().capitalize();
    return AppBar(
      backgroundColor: ColorsTheme.primaryColor,
      toolbarHeight: 60,
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'Roboto Regular',
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: Colors.white)),
    );
  }
}
