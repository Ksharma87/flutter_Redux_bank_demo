import 'package:flutter/material.dart';
import 'package:base/src/base/stateless/base_stateless_widget.dart';
import 'package:flutter_redux_bank/app/home/home_controller.dart';

class HomePage extends BaseStatelessWidget {
  HomePage({super.key});
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return controller.build(context);
  }
}
