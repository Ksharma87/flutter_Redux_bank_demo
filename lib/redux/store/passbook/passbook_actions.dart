import 'package:flutter_redux_bank/redux/actions.dart';

class GetPassBookList extends Actions {
  final String uid;

  GetPassBookList({required this.uid});
}

class PassbookLoaded extends Actions {
  PassbookLoaded();
}

class InitPassbook extends Actions {
  InitPassbook();
}