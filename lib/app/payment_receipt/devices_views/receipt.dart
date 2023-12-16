import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/utils/animation_lottie/AnimationLottie.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:lottie/lottie.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    moveToHome();
    return Center(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorsTheme.bottomColor,
      child: Lottie.asset(AnimationLottie.lottie_receipt),
    ));
  }

  void moveToHome() {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => {
              store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                  AppRouter.DASHBOARD, (route) => false))
            });
  }



}
