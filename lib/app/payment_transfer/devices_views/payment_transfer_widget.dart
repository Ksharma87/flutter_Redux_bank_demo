import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/payment_transfer/devices_views/payment_transfer_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/profile_view/profile_view_utils.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
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
              padding: const EdgeInsets.only(
                top: 30,
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
                                    style: const TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 20,
                                    )),
                                Text(vm.paymentState.mobileNumber,
                                    style: const TextStyle(
                                      fontFamily: 'Roboto Light',
                                      fontSize: 25,
                                    )),
                                Text(
                                  vm.paymentState.email,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto Regular',
                                    color: ColorsTheme.secondColor,
                                    fontSize: 15,
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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: balanceUpdate(yourBalance)),
                SizedBox(
                  width: 200,
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
                    style: const TextStyle(
                      color: ColorsTheme.primaryColor,
                      fontSize: 18,
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
                      labelStyle: const TextStyle(
                          fontFamily: 'Roboto Light',
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: ColorsTheme.secondColor,
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 0),
                    child: _buildNumberConvertText()),
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
                          validation(vm, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 10),
                          child: Text(AppLocalization.localizations!.payment,
                              style: const TextStyle(
                                  fontFamily: 'Roboto Regular',
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
              style: const TextStyle(
                  fontFamily: 'Roboto Light',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  color: ColorsTheme.secondColor));
        });
  }

  void moveDashboard(PaymentTransferViewModel viewModel) {
    if (viewModel.paymentState.isPaymentDone) {
      _progressDialog.hideProgressDialog();
      Future.delayed(
          const Duration(milliseconds: 00),
          () => {
                store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                    AppRouter.DASHBOARD, (route) => false))
              });
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
    return StreamBuilder(
        initialData: balance,
        stream: updateBalance,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          bool isData = snapshot.hasData;
          String? value = isData ? snapshot.data : balance;
          return Text(
              '${AppLocalization.localizations!.yourBalance} ${(value!).amountFormat()}',
              style: const TextStyle(
                  color: ColorsTheme.secondColor,
                  fontFamily: 'Roboto Light',
                  fontSize: 20,
                  fontWeight: FontWeight.bold));
        });
  }
}
