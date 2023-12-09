import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AccountsRepository {
  Future<bool> doCreateBankAccount(String accountNO, String balance);

  Future<BankAccountResponseEntity> getBankAccounts(String uid);

  Future<String> updatedBalance(String uid);

}
