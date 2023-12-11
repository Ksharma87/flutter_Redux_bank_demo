import 'package:flutter_redux_bank/app/utils/view/view.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/payment/store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class PaymentViewModel {
  final PaymentState paymentState;
  final PreferencesManager _manager = PreferencesManager();

  PaymentViewModel({
    required this.paymentState,
  });

  static PaymentViewModel fromStore(Store<AppState> store) {
    return PaymentViewModel(
      paymentState: store.state.paymentState,
    );
  }

  void navigationPayment(String uid) {
    store.dispatch(InitialAction());
    store.dispatch(NavigateToAction.push(AppRouter.PAYMENT_TRANSFER,
        arguments: uid.replaceAll("\"", "").toString()));
  }

  void checkUserStatus(String payeeUid) {
    String loginUserUid =
        _manager.getPreferencesValue(PreferencesContents.userUid)!;
    if (payeeUid == "-1") {
      // "-1" no data found.
      ToastView.displaySnackBar("This Email-Id OR mobile Number not exist.");
    } else if (payeeUid != loginUserUid) {
      navigationPayment(payeeUid.trim());
    }
  }

  bool onClickContinue(String emailOrMobile) {
    if (emailOrMobile.isEmpty) {
      ToastView.displaySnackBar("Please enter the Email-Id OR mobile Number");
      return false;
    } else {
      store.dispatch(
          FetchPaymentUserProfile(mobileOrEmail: emailOrMobile.trim()));
      return true;
    }
  }

  @override
  int get hashCode => paymentState.paymentUid.hashCode;

  @override
  bool operator ==(Object other) {
    PaymentViewModel model = (other as PaymentViewModel);
    return paymentState.paymentUid == model.paymentState.paymentUid;
  }
}
