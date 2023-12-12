import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/accounts/devices_views/account_widget.dart';
import 'package:flutter_redux_bank/app/passbook/devices_views/passbook_widget.dart';
import 'package:flutter_redux_bank/app/payment/devices_views/payment_widget.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_widget.dart';

class DashboardWidget extends StatelessWidget {
  final int index;
  final BoxConstraints boxConstraints;

  const DashboardWidget(
      {super.key, required this.index, required this.boxConstraints});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        {
          return AccountWidget(
            boxConstraints: boxConstraints,
          );
        }
      case 1:
        {
          return const PaymentWidget();
        }
      case 2:
        {
          return const PassbookWidget();
        }
      case 3:
        {
          return ProfileWidget(boxConstraints: boxConstraints);
        }
      default:
        {
          return AccountWidget(boxConstraints: boxConstraints);
        }
    }
  }
}
