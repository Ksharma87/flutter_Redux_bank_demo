import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/data/models/passbook/request/passbook_request.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/passbook/passbook_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/payment/payment_repository.dart';
import 'package:injectable/injectable.dart';
import '../../models/accounts/request/create_accounts_request.dart';

@Injectable(as: PassbookRepository)
class PassbookRepositoryImpl implements PassbookRepository {
  final RestApi restApi;

  PassbookRepositoryImpl({required this.restApi});

  @override
  Future<void> doPassbookUpdate(
      String selfUid,
      String paymentUid,
      String updatedAmount,
      String payeeBalance,
      String amount,
      String timeStamp,
      String transactionType) async {
    PassbookRequest request = PassbookRequest(
        uid: selfUid,
        payUid: paymentUid,
        transactionType: transactionType,
        time: timeStamp,
        balance: updatedAmount,
        payeeAmount: payeeBalance,
        amount: amount);

    PassbookRequest request1 = PassbookRequest();
    request1.transactionType = "DR";
    request1.uid = request.payUid;
    request1.balance = request.balance;
    request1.time = request.time;
    request1.amount = request.amount;
    Map map = jsonDecode(request1.toString());
    final json1 = map as Map<String, dynamic>;
    json1.remove("payUid");
    json1.remove("payeeAmount");

    PassbookRequest request2 = PassbookRequest();
    request2.transactionType = "CR";
    request2.uid = request.uid;
    request2.balance = request.payeeAmount;
    request2.time = request.time;
    request2.amount = request.amount;
    Map map2 = jsonDecode(request2.toString());
    final json2 = map2 as Map<String, dynamic>;
    json2.remove("payUid");
    json2.remove("payeeAmount");

    restApi.updatePassbook(json1, json2);
  }
}
