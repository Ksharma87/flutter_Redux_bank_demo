import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 2,
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(height: 45, color: ColorsTheme.bottomColor)
              ],
            )),
      )
    ],);
  }
}
