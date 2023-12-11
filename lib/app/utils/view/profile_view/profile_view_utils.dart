import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_redux_bank/config/drawable/resource_constants.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';

class ProfileViewUtils {
  Widget profileImageHolder(String mobileNumber, String isMale) {
    if (mobileNumber.isEmpty) {
      return const SizedBox();
    } else {
      return isMale == GenderType.MALE.name.toString()
          ? profileImage(ResourceConstants.maleProfileHolder)
          : profileImage(ResourceConstants.femaleProfileHolder);
    }
  }

  Widget profileImage(String uri) {
    return Image.asset(
      uri,
      width: 125,
      height: 125,
      fit: BoxFit.cover,
    );
  }

  String profileName(String firstName, String lastName) {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return "${firstName.capitalize()} ${lastName.capitalize()}";
    }
    return '';
  }
}
