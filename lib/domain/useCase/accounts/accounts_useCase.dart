import 'package:flutter_redux_bank/data/models/profile/response/profile_response.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class AccountsUseCase {
  late AccountsRepository accountsRepository;

  AccountsUseCase({required this.accountsRepository});

  Future<bool> invokeCreateBankAccount(String accountNO, String balance) async {
    return await accountsRepository.doCreateBankAccount(accountNO, balance);
  }

  Future<BankAccountResponseEntity> invokeBankAccountDetails(String uid) async {
    return await accountsRepository.getBankAccounts(uid);
  }

  Future<String> invokeUpdateBalance(String uid) async {
    return await accountsRepository.updatedBalance(uid);
  }
}
