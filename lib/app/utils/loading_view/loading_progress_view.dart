import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';

class LoadingProgressView extends StatelessWidget {
  const LoadingProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 3.0, sigmaY: 3.0, tileMode: TileMode.mirror),
        child: Container(
          alignment: FractionalOffset.center,
          child: const CircularProgressIndicator(
            color: ColorsTheme.primaryColor,
          ),
        ));
  }
}
