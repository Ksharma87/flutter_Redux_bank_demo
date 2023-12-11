import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/user_details/devices_views/user_details_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return _buildStore();
  }

  Widget _buildStore() {
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
            return _buildView(vm);
          });
        });
  }

  Widget _buildView(UserDetailsViewModel vm) {
    return Container(
        height: boxConstraints.maxHeight,
        alignment: Alignment.topCenter,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
              child: SizedBox(
                width: 320.w, child: TextField(
                  controller: _firstName,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  style: TextStyle(
                      color: ColorsTheme.primaryColor, fontSize: 18.sp),
                  obscureText: false,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide:
                          BorderSide(width: 2.w, color: ColorsTheme.primaryColor),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    labelStyle: const TextStyle(color: ColorsTheme.secondColor),
                    labelText: AppLocalization.localizations!.firstname,
                  ),
                )),
              ),
          Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
              child: SizedBox(
                width: 320.w,
                child: TextField(
                  controller: _lastName,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  style: TextStyle(
                      color: ColorsTheme.primaryColor, fontSize: 18.sp),
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
                    labelText: AppLocalization.localizations!.lastname,
                  ),
                ),
              )),
          SizedBox(
            width: 320.w,
            child: TextField(
              controller: _mobileNumber,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(
                  color: ColorsTheme.primaryColor, fontSize: 18.sp),
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
              padding: EdgeInsets.only(top: 30.h),
              child: SizedBox(child: genderView(vm))),
          Padding(
              padding: EdgeInsets.only(top: 40.h),
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
                    padding: EdgeInsets.only(
                        left: 70.w, right: 70.w, top: 10.h, bottom: 10.h),
                    child: Text(AppLocalization.localizations!.submit,
                        style: TextStyle(
                            fontFamily: FontType.fontRobotoRegular,
                            fontSize: 18.sp,
                            fontStyle: FontStyle.normal,
                            color: Colors.white)),
                  ))),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(height: 60.h, color: ColorsTheme.bottomColor)),
          ),
        ]));
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
                fontSize: 16.sp,
                fontWeight: (isMale) ? FontWeight.bold : FontWeight.normal,
                color: (isMale) ? Colors.white : Colors.black,
              ),
            ),
          ],
        ));
  }

  Widget genderView(UserDetailsViewModel vm) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
            child: customRadioButton(AppLocalization.localizations!.male,
                vm.detailsState.isMale, store)),
        Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
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
