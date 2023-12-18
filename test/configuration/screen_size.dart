import 'package:flutter_test/flutter_test.dart';
import 'device_config.dart';

class ScreenSize {
  const ScreenSize(this.name, this.width, this.height, this.pixelDensity);
  final String name;
  final double width, height, pixelDensity;
}

final responsiveVariant = ValueVariant<ScreenSize>({
  iPhone15,
  iPhone8,
  iPhone13ProMax,
  iPhone15ProMax
  // desktop,
});