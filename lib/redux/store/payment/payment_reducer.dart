import 'package:flutter_redux_bank/redux/store/payment/store.dart';
import 'package:redux/redux.dart';

Reducer<PaymentState> paymentProfileStateReducer = combineReducers<PaymentState>([
  TypedReducer<PaymentState, FetchPaymentUserProfileSuccess>(_fetchPaymentUserSuccess).call,
  TypedReducer<PaymentState, FetchPaymentUserProfileFail>(_fetchPaymentUserFail).call,
  TypedReducer<PaymentState, InitialAction>(_initPaymentStore).call,
  TypedReducer<PaymentState, GetPayeeUserProfileLoaded>(_getPayeeUserProfileLoaded).call,

]);


PaymentState _getPayeeUserProfileLoaded(
    PaymentState paymentState, GetPayeeUserProfileLoaded action) {
  return paymentState.copyWith(
      firstName: action.firstName,
      lastName: action.lastName,
      mobileNumber: action.mobileNumber,
      isMale: action.gender,
      email: action.email, paymentUid: '');
}

PaymentState _fetchPaymentUserFail(PaymentState paymentState, FetchPaymentUserProfileFail action) {
  return paymentState.copyWith(paymentUid: "-1"); // User Not exist
}

PaymentState _fetchPaymentUserSuccess(PaymentState paymentState, FetchPaymentUserProfileSuccess action) {
  return paymentState.copyWith(paymentUid: action.uid);
}

PaymentState _initPaymentStore(PaymentState paymentState, InitialAction action) {
  return paymentState.copyWith(paymentUid: '');
}