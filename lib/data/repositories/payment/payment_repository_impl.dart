import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/domain/repositories/payment/payment_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final RestApi restApi;

  PaymentRepositoryImpl({required this.restApi});

  @override
  Future<bool> doPayment(String selfUid, String paymentUid, String selfAmount, String otherAmount) async {
   return restApi.paymentTransfer(selfUid, paymentUid, selfAmount, otherAmount);
  }
}
