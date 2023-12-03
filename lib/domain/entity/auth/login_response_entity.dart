import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  String kind;

  String localId;

  String email;

  String displayName;

  String idToken;

  LoginResponseEntity({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
  });

  @override
  List<Object?> get props =>
      [kind, localId, email, displayName, idToken];

}
