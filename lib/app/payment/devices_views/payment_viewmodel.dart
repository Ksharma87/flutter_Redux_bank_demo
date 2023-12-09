import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class PaymentViewModel {
  final ProfileState profileState;

  PaymentViewModel({
    required this.profileState,
  });

  static PaymentViewModel fromStore(Store<AppState> store) {
    return PaymentViewModel(
      profileState: store.state.profileState,
    );
  }

  void navigationPayment() {
    store.dispatch(NavigateToAction.push(AppRouter.PAYMENT_TRANSFER));
  }
}