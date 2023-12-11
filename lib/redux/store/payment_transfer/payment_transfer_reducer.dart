import 'package:flutter_redux_bank/redux/store/payment_transfer/payment_transfer_actions.dart';
import 'package:flutter_redux_bank/redux/store/payment_transfer/payment_transfer_state.dart';
import 'package:redux/redux.dart';

Reducer<PaymentTransferState> paymentTransferStateReducer =
    combineReducers<PaymentTransferState>([
  TypedReducer<PaymentTransferState, NumberConvertAction>(_numberChangeCall)
      .call,
      TypedReducer<PaymentTransferState, InitialNumberConvertAction>(_initNumberChangeCall)
          .call,
]);

PaymentTransferState _numberChangeCall(
    PaymentTransferState paymentTransferState, NumberConvertAction action) {
  return paymentTransferState.copyWith(numberConvertText: action.textChange);
}


PaymentTransferState _initNumberChangeCall(
    PaymentTransferState paymentTransferState, InitialNumberConvertAction action) {
  return paymentTransferState.copyWith(numberConvertText: '');
}
