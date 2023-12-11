import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/payment/store.dart';
import 'package:redux/redux.dart';

class PaymentTransferViewModel {
  final PaymentState paymentState;

  PaymentTransferViewModel({
    required this.paymentState,
  });

  static PaymentTransferViewModel fromStore(Store<AppState> store) {
    return PaymentTransferViewModel(
      paymentState: store.state.paymentState,
    );
  }

  void paymentCall(String payeeUid, String amt, String loginUserUid) {
    store.dispatch(InitialPaymentAction(
        loginUserId: loginUserUid, payeeUserId: payeeUid, amount: amt));
  }

  bool isSufficientBalance(String ourAmount, String amt) {
    return (int.parse((ourAmount)) >= int.parse(amt)) ? true : false;
  }

  @override
  int get hashCode =>
      paymentState.hasData.hashCode ^ paymentState.isPaymentDone.hashCode ^ paymentState.numberConvertText.hashCode;

  @override
  bool operator == (Object other) {
     PaymentTransferViewModel model = (other as PaymentTransferViewModel);
     return paymentState.isPaymentDone == model.paymentState.isPaymentDone &&
         paymentState.hasData == model.paymentState.hasData;
  }
}
