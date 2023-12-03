import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
import 'package:flutter_redux_bank/redux/store/details/store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
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

  userDetailsSubmitApi(
      UserIdentity userIdentityAction, UserDetailsSubmit userDetailsSubmit) {
    final Completer completer = Completer();
    UserUniqueMobileNumber userUniqueMobileNumber = UserUniqueMobileNumber(
        mobileNumber: userDetailsSubmit.mobileNumber.trim(),
        completer: completer);
    LoadingProgressDialog loadingProgressDialog = LoadingProgressDialog();
    loadingProgressDialog.showProgressDialog();
    store.dispatch(userUniqueMobileNumber);
    userUniqueMobileNumber.completer.future.then((isUniqueNumber) => {
          if (isUniqueNumber)
            {
              store.dispatch(userIdentityAction),
              store.dispatch(userDetailsSubmit),
            }
          else
            {
              loadingProgressDialog.hideProgressDialog(),
              ToastView.displaySnackBar(
                  "please use another number this number already link with other Account")
            }
        });

    Future.wait([
      userDetailsSubmit.completer.future,
      userIdentityAction.completer.future
    ]).then((value) => {
          getIt<PreferencesManager>().setPreferencesValue(
              PreferencesContents.displayName,
              "${userDetailsSubmit.firstName} ${userDetailsSubmit.lastName}"),
          loadingProgressDialog.hideProgressDialog(),
          Future.delayed(const Duration(milliseconds: 1000), () {
            store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                AppRouter.DASHBOARD, (route) => false));
          })
        });
  }

  @override
  int get hashCode => detailsState.isMale.hashCode;

  @override
  bool operator ==(Object other) {
    UserDetailsViewModel details = (other as UserDetailsViewModel);
    return detailsState.isMale == details.detailsState.isMale;
  }
}
