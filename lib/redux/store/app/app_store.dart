import 'package:flutter_redux_bank/redux/store/accounts/accounts_middleware.dart';
import 'package:flutter_redux_bank/redux/store/app/app_reducer.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_middleware.dart';
import 'package:flutter_redux_bank/redux/store/details/details_middleware.dart';
import 'package:flutter_redux_bank/redux/store/payment/payment_middleware.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_middleware.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

final store = Store<AppState>(appStateReducer,
    initialState: AppState.initial(),
    middleware: [
      const NavigationMiddleware().call,
      ...createStoreAuthMiddleware(),
      ...detailsStoreAuthMiddleware(),
      ...profileStoreAuthMiddleware(),
      ...accountStoreAuthMiddleware(),
      ...paymentStoreAuthMiddleware()
    ]);
