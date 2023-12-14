import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:injectable/injectable.dart';
import '../../models/accounts/request/create_accounts_request.dart';

@Injectable(as: AccountsRepository)
class AccountsRepositoryImpl implements AccountsRepository {
  final RestApi restApi;

  AccountsRepositoryImpl({required this.restApi});

  @override
  Future<bool> doCreateBankAccount(String accountNO, String balance, String uid) async {
     return await restApi.createBankAccount(CreateAccountsRequest(bankAccountNumber : accountNO, balance:balance), uid);
  }

  @override
  Future<BankAccountResponseEntity> getBankAccounts(String uid) async {
    return await restApi.getBankAccountDetails(uid);
  }

  @override
  Future<String> updatedBalance(String uid) async {
   return await restApi.getUpdatedBalance(uid);
  }


}
