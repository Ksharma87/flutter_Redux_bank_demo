import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenConfig {
  static double bottomBarColorHeight() {
    if (Platform.isAndroid) {
      return 12.h;
    } else if (Platform.isIOS) {
      return 30.h;
    }
    return 20.h;
  }
}
