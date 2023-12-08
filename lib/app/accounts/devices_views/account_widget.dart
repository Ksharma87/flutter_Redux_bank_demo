import 'package:custom_clippers/custom_clippers.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/accounts/devices_views/account_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/common/money_format.dart';
import 'package:flutter_redux_bank/common/string_extension.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/data/data_sources/remote/api_services.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_actions.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/profile/store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/utils/global_key_holder.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({super.key, required this.boxConstraints});


  final BoxConstraints boxConstraints;
  final LoadingProgressDialog _loadingProgressDialog = LoadingProgressDialog();
  final String appName =
      '${AppLocalization.localizations!.noida} ${(AppLocalization.localizations!.bank).capitalize()}';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        onInit: (store) {
          addListener();
          store.dispatch(GetAccountsDetails());
        },
        onDispose: (store) {},
        onWillChange: (oldViewModel, newViewModel) {
          print("calling-onWillChange");
        },
        onInitialBuild: (accountViewModel) {
          if (accountViewModel.accountsState.balance.isEmpty) {
            _loadingProgressDialog.showProgressDialog();
          }
        },
        onDidChange: (oldViewModel, newViewModel) {
          if (newViewModel.accountsState.balance.isNotEmpty) {
            print("onDidChange--->");
            newViewModel.saveBalance(newViewModel.accountsState.balance);
            _loadingProgressDialog.hideProgressDialog();
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
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 20),
                                  child: Text(
                                      (vm.accountsState.balance).amountFormat(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Regular',
                                          fontSize: 26,
                                          fontWeight: FontWeight.normal))),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "${AppLocalization.localizations!.branch} :",
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto Thin',
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal)))),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(
                                              AppLocalization
                                                  .localizations!.gaurCity,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto Regular',
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal))))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 70, top: 10),
                                          child: Text(
                                              AppLocalization
                                                  .localizations!.accountNo,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto Thin',
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal)))),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, bottom: 70, top: 10),
                                          child: Text(
                                              vm.accountsState
                                                  .bankAccountNumber,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto Regular',
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal))))
                                ],
                              ),
                            ],
                          ))),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
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
                                    side: const BorderSide(
                                        width: 1.5,
                                        color: ColorsTheme.primaryColor),
                                    //border width and color
                                    elevation: 1,
                                    //elevation of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    padding: const EdgeInsets.all(
                                        0) //content padding inside button
                                    ),
                                onPressed: () {
                                  vm.navigationPayment(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 10, bottom: 10),
                                  child: Text(
                                      AppLocalization.localizations!.mPassbook,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto Regular',
                                          fontSize: 18,
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
                                height: 100,
                                padding: const EdgeInsets.only(bottom: 0),
                                color: ColorsTheme.secondColor,
                                alignment: FractionalOffset.bottomCenter),
                          ),
                          Container(height: 45, color: ColorsTheme.bottomColor)
                        ],
                      )),
                ),
              ],
            );
          });
        });
  }

  void addListener() {
    GlobalKeyHolder.event.on().listen((event) {
      // Print the runtime type. Such a set up could be used for logging.
      store.dispatch(GetAccountsDetails());
    });
  }
}
