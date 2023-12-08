import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/common/gender_type.dart';
import 'package:flutter_redux_bank/common/string_extension.dart';
import 'package:flutter_redux_bank/config/drawable/resource_constants.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';

class ProfileViewUtils {
  Widget profileImageHolder(ProfileState profileState) {
    if (profileState.mobileNumber.isEmpty) {
      return const SizedBox();
    } else {
      return profileState.isMale == GenderType.MALE.name.toString()
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

  String profileName(ProfileState profileState) {
    if (profileState.firstName.isNotEmpty && profileState.lastName.isNotEmpty) {
      return "${profileState.firstName.capitalize()} ${profileState.lastName.capitalize()}";
    }
    return '';
  }
}
