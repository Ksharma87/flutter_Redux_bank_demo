import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AnimationLottie {
  static showCongratulation(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (_) => Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Lottie.asset('assets/lottie/congratulation.json',
              width: 300.w, height: 300.w)),
    );
  }
}
