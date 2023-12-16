import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/redux/store/accounts/accounts_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_state.dart';
import 'package:flutter_redux_bank/redux/store/dashboard/bottom_nav_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_state.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_state.dart';
import 'package:flutter_redux_bank/redux/store/payment_transfer/payment_transfer_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final DetailsState detailsState;
  final BottomNavState bottomNavState;
  final ProfileState profileState;
  final AccountsState accountsState;
  final PaymentState paymentState;
  final PaymentTransferState paymentTransferState;
  final PassbookState passbookState;

  const AppState(
      {required this.authState,
      required this.detailsState,
      required this.bottomNavState,
      required this.profileState,
      required this.accountsState,
      required this.paymentState,
      required this.paymentTransferState,
      required this.passbookState});

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      detailsState: DetailsState.initial(),
      bottomNavState: BottomNavState.initial(),
      profileState: ProfileState.initial(),
      accountsState: AccountsState.initial(),
      paymentState: PaymentState.initial(),
      paymentTransferState: PaymentTransferState.initial(),
      passbookState: PassbookState.initial());

  AppState copyWith(
      {required AuthState authState,
      required DetailsState detailsState,
      required BottomNavState bottomNavState,
      required ProfileState profileState,
      required AccountsState accountsState,
      required PaymentState paymentState,
      required PaymentTransferState paymentTransferState,
      required PassbookState passbookState}) {
    return AppState(
        authState: authState,
        detailsState: detailsState,
        bottomNavState: bottomNavState,
        profileState: profileState,
        accountsState: accountsState,
        paymentState: paymentState,
        paymentTransferState: paymentTransferState,
        passbookState: passbookState);
  }
}
