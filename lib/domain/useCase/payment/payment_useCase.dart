import 'package:flutter_redux_bank/domain/repositories/payment/payment_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentUseCase {
  late PaymentRepository paymentRepository;

  PaymentUseCase({required this.paymentRepository});

  Future<bool> invokePayment(String selfUid, String paymentUid,
      String selfAmount, String otherAmount) async {
    return await paymentRepository.doPayment(
        selfUid, paymentUid, selfAmount, otherAmount);
  }
}
