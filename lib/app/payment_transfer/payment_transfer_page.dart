import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_controller.dart';

class PaymentTransferPage extends BaseStatelessWidget {
  final String payeeUid;

  PaymentTransferPage({super.key, required this.payeeUid,});

  late final PaymentTransferController _paymentTransferController =
      PaymentTransferController(payeeUid: payeeUid);

  @override
  Widget build(BuildContext context) {
    return _paymentTransferController.build(context);
  }
}
