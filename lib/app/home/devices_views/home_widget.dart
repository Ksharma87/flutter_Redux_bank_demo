import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/home/devices_views/home_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/custom_view/app_logo.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  AppLocalizations? _appLocalizations;

  @override
  void initState() {
    super.initState();
    _appLocalizations = AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!);
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: AppLogo.logo(Colors.white, ColorsTheme.secondColor)),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(_appLocalizations!.welcomeNoidaBank,
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
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) {
        return HomeViewModel(store);
      },
      builder: (BuildContext context, HomeViewModel vm) {
        return Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsTheme.secondColor,
                    side: const BorderSide(
                        width: 1.5, color: ColorsTheme.secondColor),
                    //border width and color
                    elevation: 1,
                    //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.all(0) //content padding inside button
                    ),
                onPressed: () {
                  vm.createAccount();
                  //code to execute when this button is pressed.
                },
                child: Text(_appLocalizations!.createAccount,
                    style: const TextStyle(
                        fontFamily: 'Roboto Regular',
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)));
          },
        );
      },
    );
  }

  Widget loginButtonView(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      onWillChange: (old, view) {},
      ignoreChange: (state) {
        return false;
      },
      converter: (store) {
        return HomeViewModel(store);
      },
      builder: (BuildContext context, HomeViewModel vm) {
        return Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsTheme.primaryColor,
                  side: const BorderSide(
                      width: 1.5, color: ColorsTheme.secondColor),
                  //border width and color
                  elevation: 1,
                  //elevation of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.all(0) //content padding inside button
                  ),
              onPressed: () {
                vm.login();
                //code to execute when this button is pressed.
              },
              child: Text(_appLocalizations!.login,
                  style: const TextStyle(
                      fontFamily: 'Roboto Regular',
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: ColorsTheme.secondColor)),
            );
          },
        );
      },
    );
  }
}
