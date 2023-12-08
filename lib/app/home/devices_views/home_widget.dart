import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/custom_view/app_logo.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({super.key});

  final HomeViewModel _homeViewModel = HomeViewModel(store);

  @override
  Widget build(BuildContext context) {
    store.state.bottomNavState.copyWith(index: 0);
    return body(context);
  }

  Widget body(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: ClipPath(
          clipper: DirectionalWaveClipper(verticalPosition: VerticalPosition.bottom, horizontalPosition: HorizontalPosition.left),
          child: Container(
            padding: const EdgeInsets.only(bottom: 60),
            color: ColorsTheme.secondColor,
            alignment: Alignment.center,
            child: AppLogo.logo(Colors.white, Colors.white),
          ),
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalization.localizations!.welcomeNoidaBank,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: 'Roboto Light',
                          fontSize: 38,
                          fontWeight: FontWeight.w100,
                          color: Colors.white))))),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 42, //height of button
                      width: 150, //width of button
                      child: loginButtonView(context)),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          height: 42, //height of button
                          width: 250, //width of button
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
          _homeViewModel.createAccount();
          //code to execute when this button is pressed.
        },
        child: Text(AppLocalization.localizations!.createAccount,
            style: const TextStyle(
                fontFamily: 'Roboto Regular',
                fontSize: 18,
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
          style: const TextStyle(
              fontFamily: 'Roboto Regular',
              fontSize: 18,
              fontStyle: FontStyle.normal,
              color: ColorsTheme.secondColor)),
    );
  }
}
