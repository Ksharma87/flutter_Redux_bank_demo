// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/config/router/app_router_configuration.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainConfig {

  Future<Widget> mainAppConfigSetup(WidgetTester tester, Widget homeWidget) async {
    const size = Size(393, 852);
    await tester.binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 3;
    tester.view.platformDispatcher.textScaleFactorTestValue = 1;

    const Size designSize = Size(360, 690);
    MediaQueryData currentData = const MediaQueryData(size: size);

    tester.view.padding = const FakeViewPadding();
    tester.view.systemGestureInsets = const FakeViewPadding();
    tester.view.viewInsets = const FakeViewPadding();
    tester.view.viewPadding = const FakeViewPadding();

    MaterialApp app = await mainMaterialAppSetup(tester, homeWidget);

    return MediaQuery(
      data: currentData,
      child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: designSize,
          builder: (_, child) {
            return StoreProvider(
                store: store,
                child: app);
          }),
    );
  }

  Future<MaterialApp> mainMaterialAppSetup(WidgetTester tester, Widget homeWidget) async {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        home: homeWidget,

        theme: ThemeData(
            primaryColor: ColorsTheme.primaryColor,
            primaryColorDark: ColorsTheme.secondColor),
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute
    );
  }

  Route _getRoute(RouteSettings settings) {
    return AppRouterConfiguration.getRouteConfig(settings);
  }

}