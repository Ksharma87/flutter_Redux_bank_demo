import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/my_application/material_bank_app.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'screen_size.dart';

Future<Widget> materialAppConfigSetup(WidgetTester tester, Widget homeWidget,
    {NavigatorObserver? mockObserver}) async {
  tester.view.padding = const FakeViewPadding();
  tester.view.systemGestureInsets = const FakeViewPadding();
  tester.view.viewInsets = const FakeViewPadding();
  tester.view.viewPadding = const FakeViewPadding();

  MaterialApp app = await materialAppSetup(homeWidget);
  MediaQueryData mediaQueryData;
  mediaQueryData = MediaQueryData(
      devicePixelRatio: responsiveVariant.currentValue!.pixelDensity,
      size: Size(responsiveVariant.currentValue!.width,
          responsiveVariant.currentValue!.height));

  return MediaQuery(
    data: mediaQueryData,
    child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return StoreProvider(store: store, child: app);
        }),
  );
}

Future<MaterialApp> materialAppSetup(Widget homeWidget) async {
  return getRootMaterialApp(homeWidget);
}
