import 'package:flutter_redux_bank/data/models/profile/response/profile_response.dart';
import 'package:flutter_redux_bank/domain/entity/accounts/bank_account_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/accounts/accounts_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/payment/payment_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class PaymentUseCase {
  late PaymentRepository paymentRepository;

  PaymentUseCase({required this.paymentRepository});

  Future<void> invokePayment(String selfUid, String paymentUid,
      String selfAmount, String otherAmount) async {
    return await paymentRepository.doPayment(
        selfUid, paymentUid, selfAmount, otherAmount);
  }
}
