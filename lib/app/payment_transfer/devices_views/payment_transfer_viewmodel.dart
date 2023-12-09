import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';
import 'package:redux/redux.dart';
import '../../../domain/useCase/payment/payment_useCase.dart';

class PaymentTransferViewModel {
  final ProfileState profileState;
  final PreferencesManager preferencesManager = PreferencesManager();
  final LoadingProgressDialog progressDialog = LoadingProgressDialog();

  PaymentTransferViewModel({
    required this.profileState,
  });

  static PaymentTransferViewModel fromStore(Store<AppState> store) {
    return PaymentTransferViewModel(
      profileState: store.state.profileState,
    );
  }

  void paymentCall(String uid, PaymentTransferViewModel vm, String amt,
      BuildContext context) async {
    progressDialog.showProgressDialog();
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    PaymentUseCase useCase = getIt<PaymentUseCase>();
    String otherBalance = await accountsUseCase.invokeUpdateBalance(uid);
    final paymentResponse = await useCase.invokePayment(
        preferencesManager.getPreferencesValue(PreferencesContents.userUid)!,
        uid,
        yourUpdatedAmount(vm, amt),
        otherUpdatedAmount(otherBalance, amt));

    if (paymentResponse) {
      progressDialog.hideProgressDialog();
      Future.delayed(
          const Duration(seconds: 3), () => {Navigator.pop(context)});
    }
  }

  bool isSufficientBalance(String ourAmount, String amt) {
    return (int.parse((ourAmount)) >= int.parse(amt)) ? true : false;
  }

  String otherUpdatedAmount(String balance, String amt) {
    int amtTransfer = int.parse(amt);
    int other = int.parse(balance);
    return (other + amtTransfer).toString();
  }

  String yourUpdatedAmount(PaymentTransferViewModel vm, String amt) {
    int amtTransfer = int.parse(amt);
    int yourAmount = int.parse(
        preferencesManager.getPreferencesValue(PreferencesContents.balance)!);
    return (yourAmount - amtTransfer).toString();
  }
}
