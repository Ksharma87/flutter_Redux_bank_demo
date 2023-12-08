import 'package:flutter_redux_bank/common/user_details_type.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:injectable/injectable.dart';

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
      return AppLocalization.localizations!.emailEmpty;
    }

    return value.isEmpty || !regex.hasMatch(value)
        ? AppLocalization.localizations!.emailInvalidation
        : null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return AppLocalization.localizations!.passwordEmpty;
    } else {
      if (!regex.hasMatch(value)) {
        return AppLocalization.localizations!.passwordInvalidation;
      } else {
        return null;
      }
    }
  }

  String? validateUserDetails(
      String? firstName, String? lastName, String? mobileNumber) {
    String? firstNameValue =
        validateName(firstName, UserDetailsType.FIRSTNAME.name);
    String? lastNameValue =
        validateName(lastName, UserDetailsType.LASTNAME.name);
    String? mobileNumberValue = validateMobile(mobileNumber!);
    if (firstNameValue == null &&
        lastNameValue == null &&
        mobileNumberValue == null) {
      return null;
    } else if (firstNameValue != null) {
      return firstNameValue;
    } else if (lastNameValue != null) {
      return lastNameValue;
    } else {
      return mobileNumberValue;
    }
  }

  String? validateName(String? value, String prefix) {
    RegExp regex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    if (value!.isEmpty) {
      return prefix == UserDetailsType.FIRSTNAME.name.toString()
          ? AppLocalization.localizations!.firstNameEmpty
          : AppLocalization.localizations!.lastNameEmpty;
    } else {
      if (regex.hasMatch(value)) {
        return prefix == UserDetailsType.FIRSTNAME.name.toString()
            ? AppLocalization.localizations!.firstnameInvalidation
            : AppLocalization.localizations!.lastNameInvalidation;
      } else {
        return null;
      }
    }
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalization.localizations!.mobileEmpty;
    } else if (!regExp.hasMatch(value)) {
      return AppLocalization.localizations!.mobileInvalidation;
    }
    return null;
  }

  String? validateAmount(String value) {
    if (value.isEmpty) {
      return AppLocalization.localizations!.amountNotZero;
    } else {
      if (double.parse(value) == 0) {
        return AppLocalization.localizations!.amountNotZero;
      } else {
        return null;
      }
    }
  }
}
