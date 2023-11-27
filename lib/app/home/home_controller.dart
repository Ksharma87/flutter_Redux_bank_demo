import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_widget.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:base/src/base/base_stateless_screen.dart';

class HomeController extends BaseStatelessScreen<HomePage>{

  @override
  Widget body() {
    return HomeWidget();
  }
}
