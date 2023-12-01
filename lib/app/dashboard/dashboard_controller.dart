import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:base/src/base/stateful/base_stateful_state.dart';
import 'package:base/src/base/stateful/base_stateful_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/dashboard/devices_views/dashboard_viewmodel.dart';
import 'package:flutter_redux_bank/app/dashboard/devices_views/dashboard_widget.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';

class DashBoardController extends BaseStateFullState<DashboardPage>
    with BaseStatefulScreen {

  @override
  Widget body() {
    return StoreConnector<AppState, DashboardViewModel>(
        distinct: true,
        converter: (store) {
          return DashboardViewModel.fromStore(store);
        },
        builder: (BuildContext context, DashboardViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return DashboardWidget(index: vm.bottomNavState.index);
          });
        });
  }

  @override
  bool isFullScreen() {
    return false;
  }

  @override
  Color rootBackgroundColor() {
    return Colors.white;
  }

  @override
  PreferredSizeWidget? appBar() {
    String title =
        "${AppLocalization.localizations!.noida} ${AppLocalization.localizations!.bank}";
    return AppBar(
      backgroundColor: ColorsTheme.primaryColor,
      toolbarHeight: 60,
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'Roboto Regular',
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: Colors.white)),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return SafeArea(
        child: FluidNavBar(
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
      onChange: _handleNavigationChange,
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
    ));
  }

  void _handleNavigationChange(int index) {
    store.dispatch(BottomTabChange(index: index));
  }
}
