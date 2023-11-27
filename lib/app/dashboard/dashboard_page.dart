import 'package:flutter/material.dart';
import 'package:base/src/base/stateful/base_stateful_widget.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_controller.dart';

class DashboardPage extends BaseStatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashBoardController();
}
