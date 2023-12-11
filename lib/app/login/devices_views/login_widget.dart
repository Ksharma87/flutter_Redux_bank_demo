import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/login/devices_views/login_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/custom_view/app_logo.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/redux/store/auth/store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/utils/validation.dart';

class LoginWidget extends StatelessWidget {
  final String authType;

  LoginWidget(
      {super.key, required this.authType, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  late bool isLogin = (authType.toString() == AuthType.LOGIN.toString());
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
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 320,
                      child: TextField(
                        cursorColor: ColorsTheme.primaryColor,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        autocorrect: false,
                        style: const TextStyle(
                            color: ColorsTheme.primaryColor, fontSize: 18),
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
                          labelStyle:
                              const TextStyle(color: ColorsTheme.secondColor),
                          labelText: AppLocalization.localizations!.email,
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 320,
                      child: TextField(
                        cursorColor: ColorsTheme.primaryColor,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        autocorrect: false,
                        style: const TextStyle(
                          color: ColorsTheme.primaryColor,
                          fontSize: 18,
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
                          if (isLogin) {
                            _onLoginClick(vm);
                          } else {
                            _onCreateAccount(vm);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 10),
                          child: Text(
                              isLogin
                                  ? AppLocalization.localizations!.login
                                      .toUpperCase()
                                  : AppLocalization.localizations!.createAccount
                                      .toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: 'Roboto Regular',
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        )))
              ])),
          Expanded(
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
                    Container(height: 30, color: ColorsTheme.bottomColor)
                  ],
                )),
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
