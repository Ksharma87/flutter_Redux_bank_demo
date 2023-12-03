import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ProfileResponseErrorEntity extends Equatable {

  String errorMsg;

  ProfileResponseErrorEntity({
    required this.errorMsg
});

  @override
  List<Object?> get props => [errorMsg];
}