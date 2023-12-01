import 'package:flutter/material.dart';

@immutable
class BottomNavState {
  final int index;

  const BottomNavState({required this.index});

  factory BottomNavState.initial() {
    return const BottomNavState(index: 0);
  }

  BottomNavState copyWith({required int index}) {
    return BottomNavState(
      index: index,
    );
  }

  @override
  int get hashCode => index.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavState &&
          runtimeType == other.runtimeType &&
          index == other.index;
}
