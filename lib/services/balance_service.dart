import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/domain/useCase/accounts/accounts_useCase.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class BalanceUpdateService {
  final PreferencesManager preferencesManager = PreferencesManager();

  Stream<String> updateBalanceStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      String balance = await getIt<AccountsUseCase>().invokeUpdateBalance(
          preferencesManager.getPreferencesValue(PreferencesContents.userUid)!);
      yield balance;
    }
  }
}
