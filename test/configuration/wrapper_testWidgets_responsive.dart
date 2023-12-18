import 'package:flutter_test/flutter_test.dart';
import 'screen_size_manager.dart';
import 'screen_size.dart';

  void testResponsiveWidgets(
      String description,
      WidgetTesterCallback callback, {
        Future<void> Function(String sizeName, WidgetTester tester)? goldenCallback,
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
          await goldenCallback(variant.currentValue!.name, tester);
        }
      },
      skip: skip,
      timeout: timeout,
      semanticsEnabled: semanticsEnabled,
      variant: variant,
      tags: tags,
    );
  }
