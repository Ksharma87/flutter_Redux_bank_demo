import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_widget.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:base/base_view.dart';

class HomeController extends BaseStatelessScreen<HomePage> {
  @override
  Widget body(BoxConstraints constraints) {
    return HomeWidget();
  }

  @override
  bool isFullScreen() {
    return true;
  }
}
