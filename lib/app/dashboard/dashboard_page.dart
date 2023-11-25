import 'package:flutter/material.dart';
import 'package:base/src/base/base_widget.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_controller.dart';

class DashboardPage extends BaseWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashBoardController();
}
