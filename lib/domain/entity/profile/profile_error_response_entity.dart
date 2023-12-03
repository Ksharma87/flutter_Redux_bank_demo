import 'package:equatable/equatable.dart';

class ProfileResponseErrorEntity extends Equatable {

  String errorMsg;

  ProfileResponseErrorEntity({
    required this.errorMsg
});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMsg];
}