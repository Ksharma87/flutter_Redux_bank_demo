import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:redux/redux.dart';

class GenderViewModel {
  final DetailsState detailsState;

  GenderViewModel({
    required this.detailsState,
  });

  static GenderViewModel fromStore(Store<AppState> store) {
    return GenderViewModel(
        detailsState: store.state.detailsState,
    );
  }

  @override
  int get hashCode => detailsState.isMale.hashCode;

  @override
  bool operator == (Object other) {
    GenderViewModel details = (other as GenderViewModel);
    return detailsState.isMale == details.detailsState.isMale;
  }
}
