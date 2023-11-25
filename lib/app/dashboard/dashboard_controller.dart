import 'package:flutter/material.dart';
import 'package:base/src/base/base_screen.dart';
import 'package:base/src/base/base_state.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/dashboard/devices_views/dashboard_widget.dart';

class DashBoardController extends BaseState<DashboardPage> with BaseScreen {

  @override
  Widget body() {
    return const DashboardWidget();
  }
}
