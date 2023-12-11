import 'package:flutter_redux_bank/redux/actions.dart';

class NumberConvertAction extends Actions {
  final String textChange;
  NumberConvertAction({required this.textChange});
}

class InitialNumberConvertAction extends Actions {
  InitialNumberConvertAction();
}
