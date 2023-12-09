import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:base/base_view.dart';
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
  Widget body(BoxConstraints constraints) {
    return StoreConnector<AppState, DashboardViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(BottomTabChange(index: 0));
        },
        converter: (store) {
          return DashboardViewModel.fromStore(store);
        },
        builder: (BuildContext context, DashboardViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return DashboardWidget(
                index: vm.bottomNavState.index, boxConstraints: constraints);
          });
        });
  }

  @override
  bool isFullScreen() {
    return true;
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
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () => {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      })
                    })),
      ],
      titleSpacing: 2,
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
            icon: Icons.book_online_outlined,
            backgroundColor: ColorsTheme.secondColor,
            extras: {"label": "passbook"}),
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
