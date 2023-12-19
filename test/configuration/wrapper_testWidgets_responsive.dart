import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'screen_size_manager.dart';
import 'screen_size.dart';

const String rootScreenShotPath = "../../../screenShots";

void testResponsiveWidgets(
  String description,
  WidgetTesterCallback callback, {
  Future<void> Function(ScreenSize size, WidgetTester tester)? goldenCallback,
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  ValueVariant<ScreenSize>? breakpoints,
  dynamic tags,
}) {
  final variant = breakpoints ?? responsiveVariant;
  testWidgets(
    description,
    (tester) async {
      await tester.setScreenSize(variant.currentValue!);
      await callback(tester);
      if (goldenCallback != null) {
        await goldenCallback(variant.currentValue!, tester);
      }
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
  );
}

Future<void> testGoldenScreensWidgets(
  String description,
  WidgetTesterCallback callback, {
  Future<void> Function(WidgetTester tester)?
      goldenCallback,
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  ValueVariant<ScreenSize>? breakpoints,
  dynamic tags,
}) async {
  final variant = breakpoints ?? responsiveVariant;
  variant.setUp(responsiveVariant.values.first);
  for (var element in responsiveVariant.values) {
    testGoldens(
      description,
      (tester) async {
        variant.setUp(element);
        await callback(tester);
        if (goldenCallback != null) {
          await goldenCallback(tester);
        }
      },
      skip: skip,
      tags: tags,
    );
  }
}
