abstract class PassbookRepository {
  Future<void> doPassbookUpdate(String selfUid, String paymentUid,
      String updatedAmount,String payeeBalance ,String amount, String timeStamp, String transactionType);
}
