import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';

abstract class AccountsRepository {
  Future<bool> doCreateBankAccount(String accountNO, String balance, String uid);

  Future<BankAccountResponseEntity> getBankAccounts(String uid);

  Future<String> updatedBalance(String uid);

}
