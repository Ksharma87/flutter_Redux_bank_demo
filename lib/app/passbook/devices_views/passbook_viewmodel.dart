import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_state.dart';
import 'package:redux/redux.dart';

class PassbookViewModel {
  final PassbookState passbookState;

  PassbookViewModel({
    required this.passbookState,
  });

  static PassbookViewModel fromStore(Store<AppState> store) {
    return PassbookViewModel(
      passbookState: store.state.passbookState,
    );
  }

  @override
  int get hashCode => passbookState.list.hashCode ^ passbookState.isUserPassBookLoaded.hashCode ^ passbookState.isPassbookLoaded.hashCode;

  @override
  bool operator ==(Object other) {
    PassbookViewModel model = (other as PassbookViewModel);
    return passbookState.list == model.passbookState.list &&
        passbookState.isPassbookLoaded == model.passbookState.isPassbookLoaded &&
        passbookState.isUserPassBookLoaded == model.passbookState.isUserPassBookLoaded;
  }
}
