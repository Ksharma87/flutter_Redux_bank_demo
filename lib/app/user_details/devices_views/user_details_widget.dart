import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/user_details/devices_views/user_details_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:redux/redux.dart';

class UserDetailsWidget extends StatefulWidget {
  const UserDetailsWidget({super.key});

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  late final Validation _validation = getIt<Validation>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  late UserDetailsViewModel userDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          height: constraints.maxHeight,
          alignment: Alignment.topCenter,
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: SizedBox(
                  width: 320,
                  child: TextField(
                    controller: _firstName,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    style: const TextStyle(
                        color: ColorsTheme.primaryColor, fontSize: 18),
                    obscureText: false,
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 2, color: ColorsTheme.primaryColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      labelStyle:
                          const TextStyle(color: ColorsTheme.secondColor),
                      labelText: AppLocalization.localizations!.firstname,
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: SizedBox(
                  width: 320,
                  child: TextField(
                    controller: _lastName,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    style: const TextStyle(
                        color: ColorsTheme.primaryColor, fontSize: 18),
                    obscureText: false,
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 2, color: ColorsTheme.primaryColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      labelStyle:
                          const TextStyle(color: ColorsTheme.secondColor),
                      labelText: AppLocalization.localizations!.lastname,
                    ),
                  ),
                )),
            SizedBox(
              width: 320,
              child: TextField(
                controller: _mobileNumber,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: ColorsTheme.primaryColor, fontSize: 18),
                obscureText: false,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    //<-- SEE HERE
                    borderSide:
                        BorderSide(width: 2, color: ColorsTheme.primaryColor),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  labelStyle: const TextStyle(color: ColorsTheme.secondColor),
                  labelText: AppLocalization.localizations!.mobileNumber,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: SizedBox(width: 320, child: genderView())),
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsTheme.primaryColor,
                        side: const BorderSide(
                            width: 1.5, color: ColorsTheme.primaryColor),
                        //border width and color
                        elevation: 1,
                        //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(
                            0) //content padding inside button
                        ),
                    onPressed: () {
                      _onSubmitClick();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 70, right: 70, top: 10, bottom: 10),
                      child: Text(AppLocalization.localizations!.submit,
                          style: const TextStyle(
                              fontFamily: 'Roboto Regular',
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              color: Colors.white)),
                    ))),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(height: 60, color: ColorsTheme.bottomColor)),
            ),
          ]));
    });
  }

  Widget customRadioButton(
      String genderLabel, bool isMale, Store<AppState> store) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: ColorsTheme.primaryColor),
            backgroundColor:
                (isMale) ? ColorsTheme.primaryColor : Colors.white),
        onPressed: () {
          bool gender = (genderLabel == AppLocalization.localizations!.male)
              ? true
              : false;
          store.dispatch(GenderSelectAction(gender: gender));
        },
        child: Row(
          children: [
            Icon(
              (genderLabel == AppLocalization.localizations!.male)
                  ? Icons.male
                  : Icons.female,
              color: (isMale) ? Colors.white : ColorsTheme.primaryColor,
            ),
            Text(
              genderLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: (isMale) ? FontWeight.bold : FontWeight.normal,
                color: (isMale) ? Colors.white : Colors.black,
              ),
            ),
          ],
        ));
  }

  Widget genderView() {
    return StoreConnector<AppState, UserDetailsViewModel>(
        distinct: true,
        converter: (store) {
          userDetailsViewModel = UserDetailsViewModel.fromStore(store);
          return userDetailsViewModel;
        },
        builder: (BuildContext context, UserDetailsViewModel vm) {
          return Builder(builder: (BuildContext context) {
            print('${vm.detailsState.mobileNumber}  ${vm.detailsState.isMale}');
            return Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: customRadioButton(
                        AppLocalization.localizations!.male,
                        vm.detailsState.isMale,
                        store)),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: customRadioButton(
                        AppLocalization.localizations!.female,
                        !(vm.detailsState.isMale),
                        store))
              ],
            );
          });
        });
  }

  _onSubmitClick() {
    String? result = _validation.validateUserDetails(_firstName.text.toString(),
        _lastName.text.toString(), _mobileNumber.text.toString());
    if (result == null) {
      final Completer completer = Completer();
      userDetailsViewModel.userDetailsSubmitApi(
          UserDetailsSubmit(
              firstName: _firstName.text.toString(),
              lastName: _lastName.text.toString(),
              mobileNumber: _mobileNumber.text.toString(),
              gender: userDetailsViewModel.detailsState.isMale, completer: completer),
          completer);
    } else {
      ToastView.displaySnackBar(result);
    }
  }
}
