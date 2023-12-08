import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/payment_transfer/payment_transfer_page.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/accounts/store.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class AccountViewModel {
  final AccountsState accountsState;

  AccountViewModel({
    required this.accountsState,
  });

  static AccountViewModel fromStore(Store<AppState> store) {
    return AccountViewModel(
      accountsState: store.state.accountsState,
    );
  }
  
  void navigationPayment(BuildContext context) {
     Navigator.push(
        context, MaterialPageRoute(builder: (context) => PaymentTransferPage()));
  }

  void saveBalance(String balance) {
    PreferencesManager preferencesManager = PreferencesManager();
    preferencesManager.setPreferencesValue(PreferencesContents.balance, balance);
  }
}
