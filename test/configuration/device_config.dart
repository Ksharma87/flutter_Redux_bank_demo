import 'package:golden_toolkit/golden_toolkit.dart';
import 'dart:ui';
import 'screen_size.dart';

List<Device> devices = [
  Device(
      name: 'iPhone15ProMax',
      size: Size(iPhone15ProMax.width, iPhone15ProMax.height),
      devicePixelRatio: iPhone15ProMax.pixelDensity),
  Device(
      name: 'iphone8',
      size: Size(iPhone8.width, iPhone8.height),
      devicePixelRatio: iPhone8.pixelDensity),
  Device(
      name: 'iphone15',
      size: Size(iPhone15.width, iPhone15.height),
      devicePixelRatio: iPhone15.pixelDensity),
  Device(
    name: 'iPhone13ProMax',
    size: Size(iPhone13ProMax.width, iPhone13ProMax.height),
    devicePixelRatio: iPhone13ProMax.pixelDensity,
    textScale: 1,
  )
];

const iPhone15ProMax = ScreenSize('iPhone_15ProMax', 430, 932, 3);
const iPhone15 = ScreenSize('iPhone_15', 393, 852, 3);
const iPhone8 = ScreenSize('iPhone_8', 414, 736, 3);
const iPhone13ProMax = ScreenSize('iPhone_13_Pro_Max', 414, 896, 3);
