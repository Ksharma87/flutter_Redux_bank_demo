import 'dart:async';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/accounts/store.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/store.dart';
import 'package:flutter_redux_bank/redux/store/profile/store.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class UserDetailsViewModel {
  final DetailsState detailsState;

  UserDetailsViewModel({
    required this.detailsState,
  });

  static UserDetailsViewModel fromStore(Store<AppState> store) {
    return UserDetailsViewModel(detailsState: store.state.detailsState);
  }

  void userUniqueMobileCall(String mobile) {
    UserUniqueMobileNumberCall userUniqueMobileNumber =
        UserUniqueMobileNumberCall(mobileNumber: mobile.trim());
    store.dispatch(userUniqueMobileNumber);
  }

  void detailsSubmitCallApi(String mobile, String firstName, String lastName) {
    PreferencesManager manager = PreferencesManager();
    final List<Completer> completer = [Completer(), Completer(), Completer()];
    store.dispatch(UserIdentity(
        email: manager.getPreferencesValue(PreferencesContents.emailId)!,
        mobileNumber: mobile,
        completer: completer[0]));

    store.dispatch(UserDetailsSubmit(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobile,
        gender: detailsState.isMale,
        completer: completer[1]));

    store.dispatch(CreateAccountsAction(
        balance: "250000", // default money
        accountNumber: mobile.reversed(),
        uid: manager.getPreferencesValue(PreferencesContents.userUid)!,
        completer: completer[2]));

    Future.wait([completer[0].future, completer[1].future, completer[2].future])
        .then((result) => {
          if (result[0] as bool && result[1] as bool && result[2] as bool)
                {
                  manager.setPreferencesValue(PreferencesContents.balance, ''),
                  store.dispatch(InitUserProfile()),
                  store.dispatch(InitialAccountsDetailsAction()),
                  store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                      AppRouter.DASHBOARD, (route) => false))
                }
            });
  }

  void mobileNumberExisting() {
    store.dispatch(DetailsStateReset());
    ToastView.displaySnackBar(
        AppLocalization.localizations!.linkedMobileNumber);
  }

  @override
  int get hashCode =>
      detailsState.isMale.hashCode ^
      detailsState.isUniqueMobileNumber.hashCode ^
      detailsState.isApiCall.hashCode;

  @override
  bool operator ==(Object other) {
    UserDetailsViewModel details = (other as UserDetailsViewModel);
    return detailsState.isMale == details.detailsState.isMale &&
        detailsState.isUniqueMobileNumber ==
            details.detailsState.isUniqueMobileNumber &&
        detailsState.isApiCall == details.detailsState.isApiCall;
  }
}
