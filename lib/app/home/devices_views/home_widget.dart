import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({super.key});

  final HomeViewModel _homeViewModel = HomeViewModel(store);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: ClipPath(
          clipper: DirectionalWaveClipper(verticalPosition: VerticalPosition.bottom, horizontalPosition: HorizontalPosition.left),
          child: Container(
            padding: EdgeInsets.only(bottom: 60.h),
            color: ColorsTheme.secondColor,
            alignment: Alignment.center,
            child: AppLogo.logo(Colors.white, Colors.white),
          ),
        ),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalization.localizations!.welcomeNoidaBank(AppLocalization.localizations!.noida),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: FontType.fontRobotoLight,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w100,
                          color: Colors.white))))),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 35.h, //height of button
                      width: 150.w, //width of button
                      child: loginButtonView(context)),
                  Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: SizedBox(
                          height: 35.h, //height of button
                          width: 240.w, //width of button
                          child: createAccountButtonView(context))),
                ],
              )))
    ]
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget createAccountButtonView(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsTheme.secondColor,
            side: BorderSide(width: 1.5.w, color: ColorsTheme.secondColor),
            //border width and color
            elevation: 1,
            //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(10.h)),
            padding: const EdgeInsets.all(0) //content padding inside button
            ),
        onPressed: () {
          _homeViewModel.createAccount();
          //code to execute when this button is pressed.
        },
        child: Text(AppLocalization.localizations!.createAccount,
            style: TextStyle(
                fontFamily: FontType.fontRobotoRegular,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.white)));
  }

  Widget loginButtonView(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsTheme.primaryColor,
          side: const BorderSide(width: 1.5, color: ColorsTheme.secondColor),
          //border width and color
          elevation: 1,
          //elevation of button
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(0) //content padding inside button
          ),
      onPressed: () {
        _homeViewModel.login();
        //code to execute when this button is pressed.
      },
      child: Text(AppLocalization.localizations!.login,
          style: TextStyle(
              fontFamily: FontType.fontRobotoRegular,
              fontSize: 16.sp,
              fontStyle: FontStyle.normal,
              color: ColorsTheme.secondColor)),
    );
  }
}
