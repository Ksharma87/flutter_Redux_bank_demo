import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/payment/devices_views/payment_viewmodel.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final TextEditingController _emailOrMobile = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _build();
  }

  Widget _build() {
    return StoreConnector<AppState, PaymentViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(InitialAction());
        },
        onWillChange: (oldVm, newVm) {
          if (newVm.paymentState.paymentUid.isNotEmpty) {
            newVm.checkUserStatus(newVm.paymentState.paymentUid);
          }
        },
        onDidChange: (oldVm, newVm) {},
        onInitialBuild: (profileViewModel) {},
        converter: (store) {
          return PaymentViewModel.fromStore(store);
        },
        builder: (BuildContext context, PaymentViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                    flex: 3,
                    child: ReaderWidget(
                      onScan: (result) async {},
                      loading: const DecoratedBox(
                          decoration:
                              BoxDecoration(color: ColorsTheme.primaryColor)),
                      showScannerOverlay: true,
                      showFlashlight: false,
                      showGallery: true,
                      showToggleCamera: false,
                      allowPinchZoom: false,
                      tryRotate: false,
                      tryHarder: false,
                      tryInverted: true,
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 320,
                              child: TextField(
                                cursorColor: ColorsTheme.primaryColor,
                                textInputAction: TextInputAction.done,
                                controller: _emailOrMobile,
                                autocorrect: false,
                                style: const TextStyle(
                                    color: ColorsTheme.primaryColor,
                                    fontSize: 18),
                                obscureText: false,
                                decoration: InputDecoration(
                                  focusColor: ColorsTheme.secondColor,
                                  focusedBorder: const UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: ColorsTheme.primaryColor),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  labelStyle: const TextStyle(
                                      fontSize: 15,
                                      color: ColorsTheme.secondColor),
                                  labelText: AppLocalization
                                      .localizations!.emailOrMobileNumber,
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
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
                                  store.dispatch(FetchPaymentUserProfile(
                                      mobileOrEmail:
                                          _emailOrMobile.text.toString().trim()));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 10, bottom: 10),
                                  child: Text("Continue",
                                      style: TextStyle(
                                          fontFamily: 'Roboto Regular',
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                )))
                      ],
                    )),
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
                )
              ],
            );
          });
        });
  }
}
