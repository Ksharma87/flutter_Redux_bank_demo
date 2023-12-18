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
import 'screen_size.dart';

Future<Widget> materialAppConfigSetup(
    WidgetTester tester, Widget homeWidget) async {
  Size size = Size(responsiveVariant.currentValue!.width,
      responsiveVariant.currentValue!.height);
  MediaQueryData currentData = MediaQueryData(size: size);

  tester.view.padding = const FakeViewPadding();
  tester.view.systemGestureInsets = const FakeViewPadding();
  tester.view.viewInsets = const FakeViewPadding();
  tester.view.viewPadding = const FakeViewPadding();

  MaterialApp app = await materialAppSetup(tester, homeWidget);

  return MediaQuery(
    data: currentData,
    child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return StoreProvider(store: store, child: app);
        }),
  );
}

Future<MaterialApp> materialAppSetup(
    WidgetTester tester, Widget homeWidget) async {
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
      onGenerateRoute: _getRoute);
}

Route _getRoute(RouteSettings settings) {
  return AppRouterConfiguration.getRouteConfig(settings);
}
