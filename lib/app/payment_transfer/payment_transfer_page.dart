import 'package:flutter/material.dart';
import 'package:base/src/base/stateless/base_stateless_widget.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_controller.dart';

class PaymentTransferPage extends BaseStatelessWidget {
  PaymentTransferPage({super.key});

  final PaymentTransferController _paymentTransferController = PaymentTransferController();

  @override
  Widget build(BuildContext context) {
    return _paymentTransferController.build(context);
  }
}
