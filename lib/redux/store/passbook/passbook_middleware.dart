import 'dart:collection';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/passbook/passbook_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_actions.dart';
import 'package:redux/redux.dart';
import '../app/app_store.dart';

List<Middleware<AppState>> passbookStoreAuthMiddleware() {
  final getPassbookDetails = _getPassbookRequest();
  final getPassbookUsersDetails = _getPassbookUserDetails();
  return [
    TypedMiddleware<AppState, GetPassBookList>(getPassbookDetails).call,
    TypedMiddleware<AppState, GetPassBookUserDetails>(getPassbookUsersDetails)
        .call,
  ];
}

Middleware<AppState> _getPassbookUserDetails() {
  return (Store<AppState> store, action, NextDispatcher next) {
    GetPassBookUserDetails getPassBookUserDetails = action;
    HashMap<dynamic, dynamic> profileList = getPassBookUserDetails.mList;
    updatedList(profileList, getPassBookUserDetails);
    next(action);
  };
}

void updatedList(HashMap<dynamic, dynamic> profileList,
    GetPassBookUserDetails getPassBookUserDetails) async {
  ProfileUseCase useCase = getIt<ProfileUseCase>();
  await Future.wait([
    for (var item in profileList.entries)
      Future.delayed(const Duration(seconds: 0)).then((value) async => {
            await useCase.invokeGetUserProfile("", item.key).then((value) => {
                  value.whenSuccess((success) =>
                      {
                        profileList.update(item.key, (value) => success)
                      })
                })
          })
  ]);
  store.dispatch(GetPassBookUserDetailsLoaded(
      mList: profileList, pList: getPassBookUserDetails.pList));
}

Middleware<AppState> _getPassbookRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    PassbookUseCase passbookUseCase = getIt<PassbookUseCase>();
    GetPassBookList getPassBookListAction = action;
    final profileInfo =
        passbookUseCase.invokePassbookList(getPassBookListAction.uid);
    profileInfo.then((value) => {
          store.dispatch(
              PassbookLoaded(pList: value.reversed.toList(), isLoaded: true))
        });
    next(action);
  };
}
