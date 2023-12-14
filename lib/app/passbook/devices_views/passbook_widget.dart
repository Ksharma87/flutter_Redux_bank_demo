import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/utils/animation_lottie/AnimationLottie.dart';
import 'package:lottie/lottie.dart';
import '../../../config/styles/colors_theme.dart';
import '../../utils/screen_config/ScreenConfig.dart';

class PassbookWidget extends StatelessWidget {
  const PassbookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: passbookLoading()),
        Expanded(
          flex: 1,
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  height: ScreenConfig.bottomBarColorHeight(),
                  color: ColorsTheme.bottomColor)),
        )
      ],
    );
  }

  Widget passbookLoading() {
    return Center(child: Lottie.asset(AnimationLottie.lottie_passbook_loading));
  }

  Widget passbookEmpty() {
    return Center(child: Lottie.asset(AnimationLottie.lottie_empty_passbook));
  }
}
