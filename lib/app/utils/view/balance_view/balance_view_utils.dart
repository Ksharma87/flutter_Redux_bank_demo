import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';

class BalanceViewUtils {
  final PreferencesManager _manager = PreferencesManager();

  Widget balanceUpdate(Stream<String> updateBalance, TextStyle style, {String prefixBalance = ''}) {
    return StreamBuilder(
        stream: updateBalance,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          bool isUpdated = false;
          String amountValue = '';
          if (snapshot.hasData) {
            amountValue = snapshot.data!;
            isUpdated = _isUpdatedAmount(snapshot.data);
            _manager.saveBalance(snapshot.data!);
          } else {
            amountValue =
                _manager.getPreferencesValue(PreferencesContents.balance) ?? '';
          }
          return _balanceText(isUpdated, amountValue, style, prefixBalance);
        });
  }

  bool _isUpdatedAmount(String? balance) {
    return (int.parse(balance!) -
                int.parse(_manager
                    .getPreferencesValue(PreferencesContents.balance)!)) !=
            0
        ? true
        : false;
  }

  Widget _balanceText(
      bool isUpdated, String amountValue, TextStyle style, String prefix) {
    if (isUpdated) {
      return AnimatedTextKit(
        animatedTexts: [
          ScaleAnimatedText(
            amountValue.amountFormat(),
            textStyle: style,
          ),
        ],
        repeatForever: true,
        pause: const Duration(milliseconds: 1000),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
      );
    }
    return Text(
      amountValue.amountFormat(),
      style: style,
    );
  }
}
