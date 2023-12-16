import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/payment/devices_views/payment_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/screen_config/ScreenConfig.dart';
import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

class PaymentWidget extends StatefulWidget {
  PaymentWidget({super.key, required this.boxConstraints});

  final BoxConstraints boxConstraints;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final TextEditingController _emailOrMobile = TextEditingController();
  final LoadingProgressDialog progressDialog = LoadingProgressDialog();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStore();
  }

  Widget _buildStore() {
    return StoreConnector<AppState, PaymentViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(InitialAction());
        },
        onWillChange: (oldVm, newVm) {
          if (newVm.paymentState.paymentUid.isNotEmpty) {
            progressDialog.hideProgressDialog();
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
            return _buildView(vm);
          });
        });
  }

  Widget _buildView(PaymentViewModel vm) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: ReaderWidget(
              onScan: (result) async {
                vm.checkUserStatus(result.text.toString());
              },
              loading: const DecoratedBox(
                  decoration: BoxDecoration(color: ColorsTheme.primaryColor)),
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
                    padding: (const EdgeInsets.all(10).w),
                    child: SizedBox(
                      width: 320.w,
                      child: TextField(
                        cursorColor: ColorsTheme.primaryColor,
                        textInputAction: TextInputAction.done,
                        controller: _emailOrMobile,
                        autocorrect: false,
                        style: TextStyle(
                            color: ColorsTheme.primaryColor, fontSize: 18.sp),
                        obscureText: false,
                        decoration: InputDecoration(
                          focusColor: ColorsTheme.secondColor,
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
                          labelStyle: TextStyle(
                              fontSize: 15.sp, color: ColorsTheme.secondColor),
                          labelText: AppLocalization
                              .localizations!.emailOrMobileNumber,
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20.h),
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
                          bool isValid = vm
                              .onClickContinue(_emailOrMobile.text.toString());
                          if (isValid) {
                            progressDialog.showProgressDialog();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
                          child: Text(
                              (AppLocalization.localizations!.continueBtn),
                              style: TextStyle(
                                  fontFamily: FontType.fontRobotoRegular,
                                  fontSize: 18.sp,
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
        )
      ],
    );
  }
}
