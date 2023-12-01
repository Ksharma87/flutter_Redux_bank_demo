import 'dart:async';

import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/toast_view/toast_view.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/details/details_state.dart';
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

  userDetailsSubmitApi(dynamic action, Completer completer) {
    final loading = LoadingProgressDialog();
    loading.showProgressDialog();
    store.dispatch(action);
    completer.future.then((value) => {
          loading.hideProgressDialog(),
          if (value)
            {
              Future.delayed(const Duration(milliseconds: 1000), () {
                store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
                    AppRouter.DASHBOARD, (route) => false));
              })
            }
          else
            {
              ToastView.displaySnackBar(
                  "Some Error occurred. Please try again later")
            }
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
