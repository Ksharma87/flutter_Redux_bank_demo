import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingProgressView extends StatelessWidget {
  const LoadingProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 12.0, sigmaY: 12.0, tileMode: TileMode.mirror),
        child: Container(
          alignment: FractionalOffset.center,
          child: Lottie.asset('assets/lottie/rupees.json', width: 100.w, height: 100.w
          ),
        ));
  }
}
