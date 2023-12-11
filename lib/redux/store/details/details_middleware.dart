import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/domain/useCase/profile/profile_useCase.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/details/details_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> detailsStoreAuthMiddleware() {
  final updateDetails = _updateDetailsRequest();
  final updateIdentity = _updateIdentityRequest();
  final uniqueMobileNumber = _uniqueMobileNumber();
  final createBankAccount = _createBankAccount();
  return [
    TypedMiddleware<AppState, UserDetailsSubmit>(updateDetails).call,
    TypedMiddleware<AppState, UserUniqueMobileNumberCall>(uniqueMobileNumber)
        .call,
    TypedMiddleware<AppState, UserIdentity>(updateIdentity).call,
    TypedMiddleware<AppState, CreateAccountsAction>(createBankAccount).call,
  ];
}

Middleware<AppState> _uniqueMobileNumber() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserUniqueMobileNumberCall uniqueMobileNumber = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();
    profileUseCase
        .invokeUniqueMobileNumberOrEmail(uniqueMobileNumber.mobileNumber)
        .then((value) => {
              store.dispatch(UserUniqueMobileNumberCallResult(
                  isUniqueMobileNumber: value == null ? true : false))
            });
    next(action);
  };
}

Middleware<AppState> _updateDetailsRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserDetailsSubmit userDetailsSubmit = action;
    String firstName = userDetailsSubmit.firstName;
    String lastName = userDetailsSubmit.lastName;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();

    profileUseCase
        .invokeUpdateProfile(
            userDetailsSubmit.email,
            firstName,
            lastName,
            userDetailsSubmit.mobileNumber,
            userDetailsSubmit.gender
                ? GenderType.MALE.name
                : GenderType.FEMALE.name)
        .then((data) {
      userDetailsSubmit.completer.complete(data);
    });
    next(action);
  };
}

Middleware<AppState> _updateIdentityRequest() {
  return (Store<AppState> store, action, NextDispatcher next) {
    UserIdentity userIdentity = action;
    ProfileUseCase profileUseCase = getIt<ProfileUseCase>();

    profileUseCase
        .invokeUpdateIdentity(userIdentity.email, userIdentity.mobileNumber, userIdentity.uid)
        .then((value) => {userIdentity.completer.complete(value)});
    next(action);
  };
}

Middleware<AppState> _createBankAccount() {
  return (Store<AppState> store, action, NextDispatcher next) {
    CreateAccountsAction createAccountsAction = action;
    String balance = createAccountsAction.balance;
    String accountNumber = createAccountsAction.accountNumber;
    AccountsUseCase accountsUseCase = getIt<AccountsUseCase>();
    accountsUseCase
        .invokeCreateBankAccount(accountNumber, balance)
        .then((value) => {createAccountsAction.completer.complete(value)});
    next(action);
  };
}
