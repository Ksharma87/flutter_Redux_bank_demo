class CreateAccountsRequest {
  String bankAccountNumber;
  String balance;

  CreateAccountsRequest({this.bankAccountNumber = "", this.balance = ""});

  @override
  String toString() {
    return "{\"bankAccountNumber\": \"$bankAccountNumber\", \"balance\": \"$balance\"}";
  }
}
