import 'package:flutter/material.dart';

@immutable
class DetailsState {
  final bool isMale;

  const DetailsState({
    required this.isMale,
  });

  factory DetailsState.initial() {
    return const DetailsState(isMale: true);
  }

  DetailsState copyWith({
    required bool isMale,
  }) {
    return DetailsState(isMale: isMale);
  }
}
