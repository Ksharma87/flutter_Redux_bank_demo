import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/auth/auth_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) =>
    AppState(
        authState: authStateReducer(state.authState, action)
    );
