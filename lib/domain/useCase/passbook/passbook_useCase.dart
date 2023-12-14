import 'package:flutter_redux_bank/domain/repositories/passbook/passbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PassbookUseCase {
  late PassbookRepository passbookRepository;

  PassbookUseCase({required this.passbookRepository});

  Future<void> invokePassbookUpdate(String selfUid, String paymentUid,
      String updatedAmount, String payeeBalance, String amount, String timeStamp, String transactionType) async {
    return await passbookRepository.doPassbookUpdate(
        selfUid, paymentUid, updatedAmount, payeeBalance ,amount, timeStamp, transactionType);
  }
}
