import 'package:flutter/material.dart';
import 'package:base/src/base/base_screen.dart';
import 'package:base/src/base/base_state.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_widget.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';

class HomeController extends BaseState<HomePage> with BaseScreen {

  @override
  Widget body() {
    return const HomeWidget();
  }

}
