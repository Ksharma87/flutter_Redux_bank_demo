import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';
import 'package:redux/redux.dart';

class PaymentTransferViewModel {
  final ProfileState profileState;

  PaymentTransferViewModel({
    required this.profileState,
  });

  static PaymentTransferViewModel fromStore(Store<AppState> store) {
    return PaymentTransferViewModel(
      profileState: store.state.profileState,
    );
  }
}
