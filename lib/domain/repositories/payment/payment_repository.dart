import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class PaymentRepository {
  Future<bool> doPayment(String selfUid, String paymentUid, String selfAmount, String otherAmount);
}
