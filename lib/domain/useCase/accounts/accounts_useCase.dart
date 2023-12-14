import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountsUseCase {
  late AccountsRepository accountsRepository;

  AccountsUseCase({required this.accountsRepository});

  Future<bool> invokeCreateBankAccount(String accountNO, String balance, String uid) async {
    return await accountsRepository.doCreateBankAccount(accountNO, balance, uid);
  }

  Future<BankAccountResponseEntity> invokeBankAccountDetails(String uid) async {
    return await accountsRepository.getBankAccounts(uid);
  }

  Future<String> invokeUpdateBalance(String uid) async {
    return await accountsRepository.updatedBalance(uid);
  }
}
