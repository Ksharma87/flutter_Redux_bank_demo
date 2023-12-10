import 'package:flutter/material.dart';

@immutable
class DetailsState {
  final bool isApiCall;
  final bool isMale;
  final bool isUniqueMobileNumber;

  const DetailsState(
      {required this.isApiCall,
      required this.isMale,
      required this.isUniqueMobileNumber});

  factory DetailsState.initial() {
    return const DetailsState(
        isApiCall: false, isMale: true, isUniqueMobileNumber: false);
  }

  DetailsState copyWith(
      {required bool isApiCall,
      required bool isMale,
      required bool isUniqueMobileNumber}) {
    return DetailsState(
        isApiCall: isApiCall,
        isMale: isMale,
        isUniqueMobileNumber: isUniqueMobileNumber);
  }
}
