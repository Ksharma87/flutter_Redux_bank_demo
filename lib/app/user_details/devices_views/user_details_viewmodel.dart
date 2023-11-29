import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:redux/redux.dart';

class UserDetailsViewModel {
  final DetailsState detailsState;

  UserDetailsViewModel({
    required this.detailsState,
  });

  static UserDetailsViewModel fromStore(Store<AppState> store) {
    return UserDetailsViewModel(
        detailsState: store.state.detailsState,
    );
  }

  @override
  int get hashCode => detailsState.isMale.hashCode;

  @override
  bool operator == (Object other) {
    UserDetailsViewModel details = (other as UserDetailsViewModel);
    return detailsState.isMale == details.detailsState.isMale;
  }
}
