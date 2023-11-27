import 'package:equatable/equatable.dart';

class LoginResponseErrorEntity extends Equatable {

  String errorMsg;

  LoginResponseErrorEntity({
    required this.errorMsg
});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMsg];
}