import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'screen_size.dart';

extension ScreenSizeManager on WidgetTester {
  Future<void> setScreenSize(ScreenSize screenSize) async {
    return _setScreenSize(this,
      width: screenSize.width,
      height: screenSize.height,
      pixelDensity: screenSize.pixelDensity,
    );
  }

  Future<void> _setScreenSize(WidgetTester tester, {
    required double width,
    required double height,
    required double pixelDensity,
  }) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = pixelDensity;
    tester.view.platformDispatcher.textScaleFactorTestValue = 1;

  }
}