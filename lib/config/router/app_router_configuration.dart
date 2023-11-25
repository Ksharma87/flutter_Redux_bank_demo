import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';

class AppRouterConfiguration {
  static Route getRouteConfig(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.LOGIN_PAGE:
        return _buildRoute(
            settings,
            LoginPage(
              authType: settings.arguments.toString(),
            ));
      case AppRouter.HOME_PAGE:
        return _buildRoute(settings, const HomePage());
      case AppRouter.DASHBOARD:
        return _buildRoute(settings, const DashboardPage());
      default:
        return _buildRoute(settings, const HomePage());
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
