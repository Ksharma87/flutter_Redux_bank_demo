import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@injectable
class Validation {
  String? validateLogin(String? email, String? pwd) {
    String? emailVerify = validateEmail(email);
    String? pwdVerify = validatePassword(pwd);
    if (emailVerify == null && pwdVerify == null) {
      return null;
    } else if (emailVerify != null) {
      return emailVerify;
    } else {
      return pwdVerify;
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!
          .emailEmpty;
    }

    return value.isEmpty || !regex.hasMatch(value)
        ? AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!
            .emailInvalidation
        : null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!)!
          .passwordEmpty;
    } else {
      if (!regex.hasMatch(value)) {
        return AppLocalizations.of(
                NavigatorHolder.navigatorKey.currentContext!)!
            .passwordInvalidation;
      } else {
        return null;
      }
    }
  }
}
