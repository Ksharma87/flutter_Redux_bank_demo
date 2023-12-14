import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/passbook/passbook_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/payment/payment_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> paymentStoreAuthMiddleware() {
  return [
    TypedMiddleware<AppState, FetchPaymentUserProfile>(_fetchPaymentUser())
        .call,
    TypedMiddleware<AppState, GetPayeeUserProfile>(
            _getPayeeUserProfileRequest())
        .call,
    TypedMiddleware<AppState, InitialPaymentAction>(_callPaymentApi()).call,
  ];
}

Middleware<AppState> _getPayeeUserProfileRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    GetPayeeUserProfile getPayeeUserProfile = action;
    final profileInfo = profileUseCase.invokeGetUserProfile(
        getPayeeUserProfile.token, getPayeeUserProfile.uid);
    Future.wait([profileInfo]).then((result) => {
          (result[0]).whenSuccess((success) => {
                store.dispatch(GetPayeeUserProfileLoaded(
                    email: success.email,
                    firstName: success.firstName,
                    lastName: success.lastName,
                    gender: success.gender,
                    mobileNumber: success.mobileNumber,
                    balance: ''))
              }),
        });

    next(action);
  };
}

Middleware<AppState> _fetchPaymentUser() {
  return (Store<AppState> store, action, NextDispatcher next) {
    FetchPaymentUserProfile fetchPaymentUserProfile = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    profileUseCase
        .invokeUniqueMobileNumberOrEmail(fetchPaymentUserProfile.mobileOrEmail)
        .then((value) => {
              if (value != null)
                {store.dispatch(FetchPaymentUserProfileSuccess(uid: value))}
              else
                {store.dispatch(FetchPaymentUserProfileFail())}
            });
    next(action);
  };
}

Middleware<AppState> _callPaymentApi() {
  return (Store<AppState> store, action, NextDispatcher next) {
    InitialPaymentAction initialPaymentAction = action;
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    PaymentUseCase useCase = getIt<PaymentUseCase>();
    PassbookUseCase passbookUseCase = getIt<PassbookUseCase>();
    Future<String> latestOurBalance =
        accountsUseCase.invokeUpdateBalance(initialPaymentAction.loginUserId);
    Future<String> latestPayeeBalance =
        accountsUseCase.invokeUpdateBalance(initialPaymentAction.payeeUserId);
    Future.wait([latestOurBalance, latestPayeeBalance]).then((results) => {
          passbookUseCase.invokePassbookUpdate(
              initialPaymentAction.loginUserId,
              initialPaymentAction.payeeUserId,
              yourUpdatedAmount(results[0], initialPaymentAction.amount),
              payeeUpdatedAmount(results[1], initialPaymentAction.amount),
              initialPaymentAction.amount,
              DateTime.now().millisecondsSinceEpoch.toString(), "DR"),
          useCase
              .invokePayment(
                  initialPaymentAction.loginUserId,
                  initialPaymentAction.payeeUserId,
                  yourUpdatedAmount(results[0], initialPaymentAction.amount),
                  payeeUpdatedAmount(results[1], initialPaymentAction.amount))
              .then((value) => {
                    if (value) {store.dispatch(PaymentCompletedAction())}
                  })
        });
    next(action);
  };
}

String payeeUpdatedAmount(String balance, String amt) {
  int amtTransfer = int.parse(amt);
  int other = int.parse(balance);
  return (other + amtTransfer).toString();
}

String yourUpdatedAmount(String balance, String amt) {
  int amtTransfer = int.parse(amt);
  int yourAmount = int.parse(balance);
  return (yourAmount - amtTransfer).toString();
}
