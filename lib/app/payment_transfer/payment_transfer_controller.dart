import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/payment_transfer/devices_views/payment_transfer_widget.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_page.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentTransferController
    extends BaseStatelessScreen<PaymentTransferPage> {
  final String payeeUid;

  PaymentTransferController({required this.payeeUid});

  @override
  Widget body(BoxConstraints constraints) {
    return PaymentTransferWidget(
        uid: payeeUid, boxConstraints: constraints);
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
