import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/user_details/devices_views/user_details_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:redux/redux.dart';

class UserDetailsWidget extends StatelessWidget {
  UserDetailsWidget({super.key, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  late final Validation _validation = getIt<Validation>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final LoadingProgressDialog _loadingProgressDialog = LoadingProgressDialog();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserDetailsViewModel>(
        distinct: true,
        onInit: (store) {},
        onInitialBuild: (store) {},
        onWillChange: (oldView, newView) {
          if (newView.detailsState.isApiCall) {
            if (newView.detailsState.isUniqueMobileNumber) {
              newView.detailsSubmitCallApi(_mobileNumber.text.toString(),
                  _firstName.text.toString(), _lastName.text.toString());
            } else {
              _loadingProgressDialog.hideProgressDialog();
              newView.mobileNumberExisting();
            }
          } else {}
        },
        onDidChange: (oldView, newView) {},
        converter: (store) {
          return UserDetailsViewModel.fromStore(store);
        },
        builder: (BuildContext context, UserDetailsViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return Container(
                height: boxConstraints.maxHeight,
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
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
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
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                        labelText: AppLocalization.localizations!.mobileNumber,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: SizedBox(width: 320, child: genderView(vm))),
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
                            _onSubmitClick(vm);
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
                        child: Container(
                            height: 60, color: ColorsTheme.bottomColor)),
                  ),
                ]));
          });
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
          store.dispatch(GenderSelectionAction(gender: gender));
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

  Widget genderView(UserDetailsViewModel vm) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: customRadioButton(AppLocalization.localizations!.male,
                vm.detailsState.isMale, store)),
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: customRadioButton(AppLocalization.localizations!.female,
                !(vm.detailsState.isMale), store))
      ],
    );
  }

  _onSubmitClick(UserDetailsViewModel viewModel) {
    String? result = _validation.validateUserDetails(_firstName.text.toString(),
        _lastName.text.toString(), _mobileNumber.text.toString());
    if (result == null) {
      _loadingProgressDialog.showProgressDialog();
      viewModel.userUniqueMobileCall(_mobileNumber.text.toString());
    } else {
      ToastView.displaySnackBar(result);
    }
  }
}
