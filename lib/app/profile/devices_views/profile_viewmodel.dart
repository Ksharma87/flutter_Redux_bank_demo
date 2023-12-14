import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_state.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  final ProfileState profileState;

  ProfileViewModel({
    required this.profileState,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
      profileState: store.state.profileState,
    );
  }
}
