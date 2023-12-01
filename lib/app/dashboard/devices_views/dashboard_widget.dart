import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/account/devices_views/account_widget.dart';
import 'package:flutter_redux_bank/app/payment/devices_views/payment_widget.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_widget.dart';

class DashboardWidget extends StatelessWidget {
  final int index;
  final List<Widget> list = [
    const AccountWidget(),
    const PaymentWidget(),
    const ProfileWidget()
  ];

  DashboardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return list[index];
  }
}
