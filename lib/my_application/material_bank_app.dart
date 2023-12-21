import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../config/router/app_router_configuration.dart';
import '../config/styles/colors_theme.dart';
import '../utils/global_key_holder.dart';

MaterialApp getRootMaterialApp(Widget homeWidget) {
  return MaterialApp(
    home: homeWidget,
    title: 'Redux - Dart',
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'), // English
    ],
    theme: ThemeData(
        primaryColor: ColorsTheme.primaryColor,
        primaryColorDark: ColorsTheme.secondColor),
    navigatorKey: NavigatorHolder.navigatorKey,
    scaffoldMessengerKey: GlobalKeyHolder.scaffoldMessengerKey,
    onGenerateRoute: _getRoute,
  );
}

 Route _getRoute(RouteSettings settings) {
   return AppRouterConfiguration.getRouteConfig(settings);
 }