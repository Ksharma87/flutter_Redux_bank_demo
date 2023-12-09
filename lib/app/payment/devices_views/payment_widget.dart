import 'package:custom_clippers/custom_clippers.dart';
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
      Expanded(flex: 6 , child: Container(color: Colors.green,)),
      Expanded(flex: 3, child: Container(color: Colors.pink,)),
      Expanded(
        flex: 2,
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipPath(
                  clipper: DirectionalWaveClipper(
                      verticalPosition: VerticalPosition.top,
                      horizontalPosition: HorizontalPosition.right),
                  child: Container(
                      height: 80,
                      padding: const EdgeInsets.only(bottom: 0),
                      color: ColorsTheme.secondColor,
                      alignment: FractionalOffset.bottomCenter),
                ),
                Container(height: 45, color: ColorsTheme.bottomColor)
              ],
            )),
      )
    ],);
  }
}
