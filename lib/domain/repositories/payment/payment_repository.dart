
abstract class PaymentRepository {
  Future<bool> doPayment(String selfUid, String paymentUid, String selfAmount, String otherAmount);
}
