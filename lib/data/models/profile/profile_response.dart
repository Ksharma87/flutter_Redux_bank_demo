import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';

/// email : "tushar@mail.com"
/// firstName : "Tushar"
/// gender : "FEMALE"
/// lastName : "Kaushik"
/// mobileNumber : "9958208726"

class ProfileResponse extends ProfileResponseEntity {
  ProfileResponse({
    String? email,
    String? firstName,
    String? gender,
    String? lastName,
    String? mobileNumber,
  }) : super(
            firstName: firstName!,
            lastName: lastName!,
            email: email!,
            gender: gender!,
            mobileNumber: mobileNumber!) {
    _email = email;
    _firstName = firstName;
    _gender = gender;
    _lastName = lastName;
    _mobileNumber = mobileNumber;
  }

  factory ProfileResponse.fromJson(dynamic json) {
    String? _mobileNumber = json['mobileNumber'];
    String? _gender = json['gender'];
    String? _email = json['email'];
    String? _lastName = json['lastName'];
    String _firstName = json['firstName'] ?? '';

    return ProfileResponse(
      mobileNumber: _mobileNumber,
      gender: _gender,
      email: _email!,
      firstName: _firstName,
      lastName: _lastName,
    );
  }

  late String _email;
  late String _firstName;
  late String _gender;
  late String _lastName;
  late String _mobileNumber;

  String get email => _email;

  String get firstName => _firstName;

  String get gender => _gender;

  String get lastName => _lastName;

  String get mobileNumber => _mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['gender'] = _gender;
    map['lastName'] = _lastName;
    map['mobileNumber'] = _mobileNumber;
    return map;
  }
}
