import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/payment/payment_repository.dart';
import 'package:injectable/injectable.dart';
import '../../models/accounts/request/create_accounts_request.dart';

@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final RestApi restApi;

  PaymentRepositoryImpl({required this.restApi});

  @override
  Future<bool> doPayment(String selfUid, String paymentUid, String selfAmount, String otherAmount) async {
   return restApi.paymentTransfer(selfUid, paymentUid, selfAmount, otherAmount);
  }
}
