import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/accounts/devices_views/account_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/screen_config/ScreenConfig.dart';
import 'package:flutter_redux_bank/app/utils/view/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_actions.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/services/balance_service.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({super.key, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  final String appName =
      '${AppLocalization.localizations!.noida} ${(AppLocalization.localizations!.bank).capitalize()}';
  final PreferencesManager _manager = PreferencesManager();
  final LoadingProgressDialog loadingProgressDialog = LoadingProgressDialog();
  final Stream<String> updateBalance =
      BalanceUpdateService().updateBalanceStream();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        onInit: (store) {},
        onDispose: (store) {},
        onWillChange: (oldViewModel, newViewModel) {
          if (newViewModel.accountsState.isLoading) {
            loadingProgressDialog.showProgressDialog();
          }
        },
        onInitialBuild: (accountViewModel) {
          store.dispatch(GetAccountsDetails(
              loginUserUid:
                  _manager.getPreferencesValue(PreferencesContents.userUid)!,
              token: _manager
                  .getPreferencesValue(PreferencesContents.loginToken)!));
          if (accountViewModel.accountsState.balance.isNotEmpty) {
            _manager.saveBalance(accountViewModel.accountsState.balance);
          }
        },
        onDidChange: (oldViewModel, newViewModel) {
          if (newViewModel.accountsState.balance.isNotEmpty) {
            _manager.saveBalance(newViewModel.accountsState.balance);
          }
          if (!(newViewModel.accountsState.isLoading)) {
            loadingProgressDialog.hideProgressDialog();
          }
        },
        converter: (store) {
          return AccountViewModel.fromStore(store);
        },
        builder: (BuildContext context, AccountViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return Column(
              children: [
                SizedBox(
                  child: ClipPath(
                      clipper: MultipleRoundedPointsClipper(Sides.bottom),
                      child: Container(
                          padding: const EdgeInsets.only(bottom: 0),
                          color: ColorsTheme.secondColor,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.w, bottom: 10.h),
                                  child: balanceUpdate()),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(5).w,
                                          child: Text(
                                              "${AppLocalization.localizations!.branch} :",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontType.fontRobotoThin,
                                                  fontSize: 18.sp,
                                                  fontWeight:
                                                      FontWeight.normal)))),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(
                                              AppLocalization
                                                  .localizations!.gaurCity,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: FontType
                                                      .fontRobotoRegular,
                                                  fontSize: 18.sp,
                                                  fontWeight:
                                                      FontWeight.normal))))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 40.h, top: 10.h),
                                          child: Text(
                                              AppLocalization
                                                  .localizations!.accountNo,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontType.fontRobotoThin,
                                                  fontSize: 18.sp,
                                                  fontWeight:
                                                      FontWeight.normal)))),
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.w, bottom: 40.h, top: 10.h),
                                          child: Text(
                                              vm.accountsState
                                                  .bankAccountNumber,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: FontType
                                                      .fontRobotoRegular,
                                                  fontSize: 18.sp,
                                                  fontWeight:
                                                      FontWeight.normal))))
                                ],
                              ),
                            ],
                          ))),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    child: CreditCardWidget(
                      glassmorphismConfig: Glassmorphism(
                        blurX: 0.0,
                        blurY: 0.0,
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topRight,
                          colors: <Color>[
                            ColorsTheme.primaryColor,
                            ColorsTheme.secondColor,
                          ],
                          stops: <double>[
                            0.55,
                            0,
                          ],
                        ),
                      ),
                      enableFloatingCard: true,
                      cardType: CardType.rupay,
                      isHolderNameVisible: true,
                      obscureCardNumber: false,
                      bankName: appName,
                      floatingConfig: const FloatingConfig(
                        isGlareEnabled: false,
                        isShadowEnabled: true,
                        shadowConfig: FloatingShadowConfig(),
                      ),
                      cardBgColor: ColorsTheme.primaryColor,
                      cardNumber: vm.accountsState.cardNumber,
                      expiryDate: "12/26",
                      cardHolderName: vm.accountsState.displayName,
                      cvvCode: "123",
                      showBackView: false,
                      //true when you want to show cvv(back) view
                      onCreditCardWidgetChange: (CreditCardBrand
                          brand) {}, // Callback for anytime credit card brand is changed
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsTheme.primaryColor,
                                    side: BorderSide(
                                        width: (1.5).w,
                                        color: ColorsTheme.primaryColor),
                                    //border width and color
                                    elevation: 1,
                                    //elevation of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                        (BorderRadius.circular(50).w)),
                                    padding: const EdgeInsets.all(
                                        0) //content padding inside button
                                    ),
                                onPressed: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
                                  child: Text(
                                      AppLocalization.localizations!.logout,
                                      style: TextStyle(
                                          fontFamily:
                                              FontType.fontRobotoRegular,
                                          fontSize: 18.sp,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                ))))),
                Expanded(
                  flex: 2,
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipPath(
                            clipper: DirectionalWaveClipper(
                                verticalPosition: VerticalPosition.top,
                                horizontalPosition: HorizontalPosition.left),
                            child: Container(
                                height: 85.h,
                                padding: const EdgeInsets.only(bottom: 0),
                                color: ColorsTheme.secondColor,
                                alignment: FractionalOffset.bottomCenter),
                          ),
                          Container(
                              height: ScreenConfig.bottomBarColorHeight(),
                              color: ColorsTheme.bottomColor)
                        ],
                      )),
                ),
              ],
            );
          });
        });
  }

  Widget balanceUpdate() {
    return StreamBuilder(
        stream: updateBalance,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            _manager.saveBalance(snapshot.data!);
          }
          String? value = snapshot.hasData
              ? snapshot.data
              : _manager.getPreferencesValue(PreferencesContents.balance) ?? '';
          return Text((value!.amountFormat()),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontType.fontRobotoRegular,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.normal));
        });
  }
}
