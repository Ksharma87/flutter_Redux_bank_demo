import 'package:flutter/material.dart';

@immutable
class PassbookState {
  final List<dynamic> list;
  final bool isPassbookLoaded;
  final bool isUserPassBookLoaded;

  const PassbookState(
      {required this.list,
      required this.isPassbookLoaded,
      required this.isUserPassBookLoaded});

  factory PassbookState.initial() {
    return const PassbookState(
        list: [], isPassbookLoaded: false, isUserPassBookLoaded: false);
  }

  PassbookState copyWith(List<dynamic> pList, bool isLoaded,
      {bool isUserPassBookLoaded = false}) {
    return PassbookState(
        list: pList,
        isPassbookLoaded: isLoaded,
        isUserPassBookLoaded: isUserPassBookLoaded);
  }
}
