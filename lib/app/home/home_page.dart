import 'package:flutter/material.dart';
import 'package:base/src/base/base_widget.dart';
import 'package:flutter_redux_bank/app/home/home_controller.dart';

class HomePage extends BaseWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomeController();
}
