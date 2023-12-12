import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Expanded(flex: 6, child: noHistroy()),
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

  Widget noHistroy() {
    return Center(child: Lottie.asset('assets/lottie/noData.json'));
  }
}
