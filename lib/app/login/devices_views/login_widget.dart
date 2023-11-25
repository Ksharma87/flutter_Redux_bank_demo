import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/login/devices_views/login_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/custom_view/app_logo.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/auth_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class LoginWidget extends StatefulWidget {
  final String authType;

  const LoginWidget({super.key, required this.authType});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  AppLocalizations? _appLocalizations;
  bool isLogin = true;
  late String buttonLabel;
  late Validation _validation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLogin = (widget.authType.toString() == AuthType.LOGIN.toString());
    _validation = getIt<Validation>();
    _appLocalizations = AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return StoreConnector<AppState, LoginViewModel>(
        distinct: true,
        converter: (store) {
          return LoginViewModel.fromStore(store);
        },
        builder: (BuildContext context, LoginViewModel vm) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: AppLogo.logo(ColorsTheme.primaryColor,
                            ColorsTheme.primaryColor)),
                    Expanded(
                        flex: 4,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: 320,
                                child: TextField(
                                  controller: _emailController,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      color: ColorsTheme.primaryColor,
                                      fontSize: 18),
                                  obscureText: false,
                                  decoration: InputDecoration(
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

                                    //border: OutlineInputBorder(),
                                    labelText: _appLocalizations!.email,
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: 320,
                                child: TextField(
                                  controller: _passwordController,
                                  autocorrect: false,
                                  style: const TextStyle(
                                    color: ColorsTheme.primaryColor,
                                    fontSize: 18,
                                  ),
                                  obscureText: true,
                                  decoration: InputDecoration(
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
                                    labelText: _appLocalizations!.password,
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 40),
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
                                    if (isLogin) {
                                      _onLoginClick(vm);
                                    } else {
                                      _onCreateAccount(vm);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                        isLogin
                                            ? _appLocalizations!.login
                                                .toUpperCase()
                                            : _appLocalizations!.createAccount
                                                .toUpperCase(),
                                        style: const TextStyle(
                                            fontFamily: 'Roboto Regular',
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  )))
                        ])),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 80, color: ColorsTheme.bottomColor))
                  ]);
            },
          );
        },
      );
    });
  }

  _onLoginClick(LoginViewModel loginViewModel) {
    String? result = _validation.validateLogin(
        _emailController.text.toString(), _passwordController.text.toString());
    if (result == null) {
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
      loginViewModel.onCreateAccount(_emailController.text.toString(),
          _passwordController.text.toString());
    } else {
      ToastView.displaySnackBar(result);
    }
  }
}
