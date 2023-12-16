import 'dart:collection';

import 'package:flutter_redux_bank/redux/actions.dart';

class GetPassBookList extends Actions {
  final String uid;

  GetPassBookList({required this.uid});
}

class PassbookLoaded extends Actions {
  final List<dynamic> pList;
  final bool isLoaded;

  PassbookLoaded({required this.pList, required this.isLoaded});
}

class GetPassBookUserDetails extends Actions {
  final HashMap<dynamic, dynamic> mList;
  final List<dynamic> pList;
  GetPassBookUserDetails({required this.mList, required this.pList});
}

class GetPassBookUserDetailsLoaded extends Actions {
  final HashMap<dynamic, dynamic> mList;
  final List<dynamic> pList;
  GetPassBookUserDetailsLoaded({required this.mList, required this.pList});
}

class InitPassbook extends Actions {
  InitPassbook();
}
