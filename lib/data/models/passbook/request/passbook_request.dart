class PassbookRequest {
  String uid;
  String payUid;
  String transactionType;
  String time;
  String balance;
  String payeeAmount;
  String amount;

  PassbookRequest(
      {this.uid = "",
      this.payUid = "",
      this.transactionType = '',
      this.time = '',
      this.balance = '',
      this.payeeAmount = '',
      this.amount = ''});


  @override
  String toString() {
    return "{\"uid\": \"$uid\", \"payUid\": \"$payUid\", \"transactionType\": \"$transactionType\", \"time\": \"$time\",  \"balance\": \"$balance\",\"payeeAmount\": \"$payeeAmount\", \"amount\": \"$amount\"}";
  }
}
