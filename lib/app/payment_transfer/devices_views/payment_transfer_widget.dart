import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/payment_transfer/devices_views/payment_transfer_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/view/balance_view/balance_view_utils.dart';
import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/payment/store.dart';
import 'package:flutter_redux_bank/redux/store/payment_transfer/payment_transfer_actions.dart';
import 'package:flutter_redux_bank/services/balance_service.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:redux/redux.dart';

class PaymentTransferWidget extends StatelessWidget {
  PaymentTransferWidget(
      {super.key, required this.uid, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  final LoadingProgressDialog _progressDialog = LoadingProgressDialog();
  final String uid;
  final ProfileViewUtils _profileViewUtils = ProfileViewUtils();
  final TextEditingController _amountController = TextEditingController();
  final PreferencesManager _manager = PreferencesManager();
  late String yourBalance =
      _manager.getPreferencesValue(PreferencesContents.balance)!;

  final Stream<String> updateBalance =
      BalanceUpdateService().updateBalanceStream();

  @override
  Widget build(BuildContext context) {
    return _buildStore(context);
  }

  Widget _buildStore(BuildContext context) {
    return StoreConnector<AppState, PaymentTransferViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(InitialAction());
        },
        onWillChange: (oldVm, newVm) {},
        onDidChange: (oldVm, newVm) {
          if (newVm.paymentState.mobileNumber.isNotEmpty) {
            _progressDialog.hideProgressDialog();
          }
          moveDashboard(newVm);
        },
        onInitialBuild: (profileViewModel) {
          store.dispatch(GetPayeeUserProfile(
              uid: uid,
              token: _manager
                  .getPreferencesValue(PreferencesContents.loginToken)!));

          _progressDialog.showProgressDialog();
        },
        converter: (store) {
          return PaymentTransferViewModel.fromStore(store);
        },
        builder: (BuildContext context, PaymentTransferViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return _buildView(vm, context);
          });
        });
  }

  Widget _buildView(PaymentTransferViewModel vm, BuildContext context) {
    return Column(children: [
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(
                top: 30.h,
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: _profileViewUtils.profileImageHolder(
                                vm.paymentState.mobileNumber,
                                vm.paymentState.isMale))),
                    Flexible(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    _profileViewUtils.profileName(
                                        vm.paymentState.firstName,
                                        vm.paymentState.lastName),
                                    style: TextStyle(
                                      fontFamily: FontType.fontRobotoRegular,
                                      fontSize: 18.sp,
                                    )),
                                Text(vm.paymentState.mobileNumber,
                                    style: TextStyle(
                                      fontFamily: FontType.fontRobotoLight,
                                      fontSize: 22.sp,
                                    )),
                                Text(
                                  vm.paymentState.email,
                                  style: TextStyle(
                                    fontFamily: FontType.fontRobotoRegular,
                                    color: ColorsTheme.secondColor,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            )))
                  ]))),
      Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: balanceUpdate(yourBalance)),
                SizedBox(
                  width: 200.w,
                  child: TextField(
                    onChanged: _onChange,
                    textAlign: TextAlign.center,
                    cursorColor: ColorsTheme.primaryColor,
                    textInputAction: TextInputAction.done,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    autocorrect: false,
                    style: TextStyle(
                      color: ColorsTheme.primaryColor,
                      fontSize: 18.sp,
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      //suffixIcon: IconButton(onPressed: () => {}, icon: Icons.remove_red_eye_rounded,),
                      hintStyle:
                          const TextStyle(color: ColorsTheme.secondColor),
                      focusColor: ColorsTheme.secondColor,
                      focusedBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 2, color: ColorsTheme.primaryColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),

                      label: Text(
                        '${AppLocalization.localizations!.rupeeSymbol} ${AppLocalization.localizations!.enterTheAmount}',
                        textAlign: TextAlign.center,
                      ),
                      labelStyle: TextStyle(
                          fontFamily: FontType.fontRobotoLight,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: ColorsTheme.secondColor,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 0),
                    child: _buildNumberConvertText()),
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
                          validation(vm, context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
                          child: Text(AppLocalization.localizations!.payment,
                              style: const TextStyle(
                                  fontFamily: FontType.fontRobotoRegular,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        )))
              ],
            ),
          )),
      Expanded(
          flex: 1,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ClipPath(
              clipper: DirectionalWaveClipper(
                  verticalPosition: VerticalPosition.top,
                  horizontalPosition: HorizontalPosition.right),
              child: Container(
                  height: boxConstraints.maxHeight / 5,
                  padding: const EdgeInsets.only(bottom: 0),
                  color: ColorsTheme.secondColor,
                  alignment: FractionalOffset.bottomCenter),
            ),
          )),
    ]);
  }

  void _onChange(value) {
    store.dispatch(NumberConvertAction(textChange: value.toString().trim()));
  }

  Widget _buildNumberConvertText() {
    return StoreBuilder<AppState>(
        onInit: (store) => {store.dispatch(InitialNumberConvertAction())},
        builder: (BuildContext context, Store<AppState> ourStore) {
          if (ourStore.state.paymentTransferState.numberConvertText.isEmpty) {
            return const SizedBox();
          }
          return Text(
              NumberToWordsEnglish.convert(int.parse(
                  ourStore.state.paymentTransferState.numberConvertText)),
              style: TextStyle(
                  fontFamily: FontType.fontRobotoLight,
                  fontSize: 16.sp,
                  fontStyle: FontStyle.normal,
                  color: ColorsTheme.secondColor));
        });
  }

  void moveDashboard(PaymentTransferViewModel viewModel) {
    if (viewModel.paymentState.isPaymentDone) {
      _progressDialog.hideProgressDialog();
      store.dispatch(NavigateToAction.push(AppRouter.PAYMENT_RECEIPT));
    }
  }

  void validation(PaymentTransferViewModel vm, BuildContext context) {
    String? amountMsg =
        getIt<Validation>().validateAmount(_amountController.text.toString());
    if (amountMsg == null) {
      String ourAmount =
          _manager.getPreferencesValue(PreferencesContents.balance)!;
      String amtAmount = _amountController.text.toString();
      if (vm.isSufficientBalance(ourAmount, amtAmount)) {
        String loginUserUid =
            _manager.getPreferencesValue(PreferencesContents.userUid)!;
        _progressDialog.showProgressDialog();
        vm.paymentCall(uid, amtAmount, loginUserUid);
      } else {
        ToastView.displaySnackBar(
            AppLocalization.localizations!.insufficientAmount);
      }
    } else {
      ToastView.displaySnackBar(amountMsg);
    }
  }

  Widget balanceUpdate(String balance) {
    TextStyle style = TextStyle(
        color: ColorsTheme.secondColor,
        fontFamily: FontType.fontRobotoThin,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold);
    return BalanceViewUtils().balanceUpdate(updateBalance, style,
        prefixBalance: AppLocalization.localizations!.yourBalance);
  }
}
