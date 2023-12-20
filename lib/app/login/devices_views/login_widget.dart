import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/login/devices_views/login_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/screen_config/ScreenConfig.dart';
import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/redux/store/auth/store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/view_keys/view_keys_config.dart';

class LoginWidget extends StatelessWidget {
  final String authType;

  LoginWidget(
      {super.key, required this.authType, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  late bool isLogin = (authType.toString() == AuthType.LOGIN.name.toString());
  late String buttonLabel;
  final LoadingProgressDialog _loadingProgressDialog = LoadingProgressDialog();
  final Validation _validation = getIt<Validation>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildStore();
  }

  Widget _buildStore() {
    return StoreConnector<AppState, LoginViewModel>(
      distinct: true,
      onDidChange: (oldViewModel, newViewModel) {
        _handleResponse(newViewModel);
      },
      converter: (store) {
        return LoginViewModel.fromStore(store);
      },
      builder: (BuildContext context, LoginViewModel vm) {
        return Builder(
          builder: (BuildContext context) {
            return _buildView(vm);
          },
        );
      },
    );
  }

  Widget _buildView(LoginViewModel vm) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: AppLogo.logo(
                  ColorsTheme.primaryColor, ColorsTheme.primaryColor)),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                  child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 320.w,
                      child: TextField(
                        cursorColor: ColorsTheme.primaryColor,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        autocorrect: false,
                        style: TextStyle(
                            color: ColorsTheme.primaryColor, fontSize: 18.sp),
                        obscureText: false,
                        decoration: InputDecoration(
                          focusColor: ColorsTheme.secondColor,
                          focusedBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2.w, color: ColorsTheme.primaryColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(width: 1.w, color: Colors.grey),
                          ),
                          labelStyle:
                              const TextStyle(color: ColorsTheme.secondColor),
                          labelText: AppLocalization.localizations!.email,
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 320.w,
                      child: TextField(
                        cursorColor: ColorsTheme.primaryColor,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        autocorrect: false,
                        style: TextStyle(
                          color: ColorsTheme.primaryColor,
                          fontSize: 18.sp,
                        ),
                        obscureText: true,
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
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          labelStyle:
                              const TextStyle(color: ColorsTheme.secondColor),
                          labelText: AppLocalization.localizations!.password,
                        ),
                      ),
                    )),
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
                                borderRadius: (BorderRadius.circular(50).w)),
                            padding: const EdgeInsets.all(
                                0) //content padding inside button
                            ),
                        onPressed: () {
                          if (isLogin) {
                            _onLoginClick(vm);
                          } else {
                            _onCreateAccount(vm);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
                          child: Text(
                              key: const Key(ViewKeysConfig.loginTextLoginKey),
                              isLogin
                                  ? AppLocalization.localizations!.login
                                      .toUpperCase()
                                  : AppLocalization.localizations!.createAccount
                                      .toUpperCase(),
                              style: TextStyle(
                                  fontFamily: FontType.fontRobotoRegular,
                                  fontSize: 18.sp,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        )))
              ]))),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SingleChildScrollView(
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
                ))),
          ),
        ]);
  }

  _handleResponse(LoginViewModel newViewModel) {
    if (newViewModel.authState.token.isNotEmpty) {
      newViewModel.saveUserDetails(_emailController.text.toString(),
          newViewModel.authState.token, newViewModel.authState.uid);
      newViewModel.moveDashBoardScreen(
          store, newViewModel.authState.isEmailLinked);
    } else if (newViewModel.authState.errorMsg.isNotEmpty) {
      _loadingProgressDialog.hideProgressDialog();
      newViewModel.errorMessageFilters(newViewModel.authState.errorMsg);
      store.dispatch(AuthInitialization());
    }
  }

  _onLoginClick(LoginViewModel loginViewModel) {
    String? result = _validation.validateLogin(
        _emailController.text.toString(), _passwordController.text.toString());
    if (result == null) {
      _loadingProgressDialog.showProgressDialog();
      loginViewModel.onLogin(_emailController.text.toString(),
          _passwordController.text.toString());
    } else {
      ToastView.displaySnackBar(result);
    }
  }

  _onCreateAccount(LoginViewModel loginViewModel) {
    String? result = _validation.validateLogin(
        _emailController.text.toString(), _passwordController.text.toString());
    if (result == null) {
      _loadingProgressDialog.showProgressDialog();
      loginViewModel.onCreateAccount(_emailController.text.toString(),
          _passwordController.text.toString());
    } else {
      ToastView.displaySnackBar(result);
    }
  }
}
