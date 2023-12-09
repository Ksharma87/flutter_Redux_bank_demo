import 'dart:math';

import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:money_formatter/money_formatter.dart';

extension MoneyFormatExtension on String {
  String amountFormat() {
    if (isEmpty) {
      return '';
    }
    MoneyFormatter fmf = MoneyFormatter(
        amount: double.parse(this),
        settings: MoneyFormatterSettings(
            symbol: AppLocalization.localizations!.rupeeSymbol));
    return fmf.output.symbolOnLeft;
  }

  String generateDebitCardRandom() {
    Random rand = Random();
    String cardNumber = this + rand.nextInt(100000000^5).toString();
    String cardNumberFull = cardNumber + cardNumber;
    return ("${cardNumberFull.substring(0, 4)} ${cardNumberFull.substring(4, 8)} ${cardNumberFull.substring(8, 12)} ${cardNumberFull.substring(12, 16)}");
  }
}
