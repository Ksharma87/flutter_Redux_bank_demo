import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_state.dart';
import 'package:redux/redux.dart';

class DashboardViewModel {
  final BottomNavState bottomNavState;
  DashboardViewModel({required this.bottomNavState});

  static DashboardViewModel fromStore(Store<AppState> store) {
    return DashboardViewModel(bottomNavState: store.state.bottomNavState);
  }

  @override
  int get hashCode => bottomNavState.index.hashCode;

  @override
  bool operator == (Object other) {
    DashboardViewModel dashboardViewModel = (other as DashboardViewModel);
    return bottomNavState.index == dashboardViewModel.bottomNavState.index;
  }

}
