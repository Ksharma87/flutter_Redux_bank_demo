import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/utils/animation_lottie/AnimationLottie.dart';
import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ProfileViewUtils {
  Widget profileImageHolder(String mobileNumber, String isMale) {
    if (mobileNumber.isEmpty) {
      return const SizedBox();
    } else {
      return isMale == GenderType.MALE.name.toString()
          ? profileMaleImage()
          : profileFemaleImage();
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

  Widget profileMaleImage() {
    return Lottie.asset(AnimationLottie.lottie_MaleIcon,
        repeat: true, reverse: true, width: 150.w, height: 150.w);
  }

  Widget profileFemaleImage() {
    return Lottie.asset(AnimationLottie.lottie_FemaleIcon,
        repeat: true, reverse: true, width: 150.w, height: 150.w);
  }

  String profileName(String firstName, String lastName) {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return "${firstName.capitalize()} ${lastName.capitalize()}";
    }
    return '';
  }
}
