import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:base/src/base/base_screen.dart';
import 'package:base/src/base/base_state.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/dashboard/devices_views/dashboard_widget.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';

class DashBoardController extends BaseState<DashboardPage> with BaseScreen {
  @override
  Widget body() {
    return const DashboardWidget();
  }

  @override
  PreferredSizeWidget? appBar() {
    String title =
        "${AppLocalization.localizations!.noida} ${AppLocalization.localizations!.bank}";
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 60,
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'Roboto Regular',
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: ColorsTheme.primaryColor)),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return FluidNavBar(
      icons: [
        FluidNavBarIcon(
            icon: Icons.home,
            backgroundColor: ColorsTheme.secondColor,
            extras: {"label": "home"}),
        FluidNavBarIcon(
            icon: Icons.payments_rounded,
            backgroundColor: ColorsTheme.secondColor,
            extras: {"label": "payment"}),
        FluidNavBarIcon(
            icon: Icons.account_box_sharp,
            backgroundColor: ColorsTheme.secondColor,
            extras: {"label": "profile"}),
      ],
      //onChange: _handleNavigationChange,
      style: const FluidNavBarStyle(
          iconSelectedForegroundColor: ColorsTheme.primaryColor,
          iconUnselectedForegroundColor: Colors.white,
          barBackgroundColor: ColorsTheme.bottomColor),
      scaleFactor: 1.5,
      defaultIndex: 0,
      animationFactor: 0.1,
      itemBuilder: (icon, item) => Semantics(
        label: icon.extras!["label"],
        child: item,
      ),
    );
  }
}
