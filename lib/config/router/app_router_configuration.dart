import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/app/payment_receipt/devices_views/receipt.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_page.dart';
import 'package:flutter_redux_bank/app/user_details/user_details_page.dart';
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
        return _buildRoute(settings, HomePage());
      case AppRouter.DASHBOARD:
        return _buildRoute(settings, const DashboardPage());
      case AppRouter.USER_INFO:
        return _buildRoute(settings, UserDetailsPage());
      case AppRouter.PAYMENT_RECEIPT:
        return _buildRoute(settings, const Receipt());
      case AppRouter.PAYMENT_TRANSFER:
        return _buildRoute(settings, PaymentTransferPage(payeeUid : settings.arguments.toString()));
      default:
        return _buildRoute(settings, HomePage());
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
