import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_controller.dart';

class DashboardPage extends BaseStatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashBoardController();
}
