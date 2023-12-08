import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';

/// error : {"code":400,"message":"EMAIL_NOT_FOUND","errors":[{"message":"EMAIL_NOT_FOUND","domain":"global","reason":"invalid"}]}

class LoginErrorResponse  extends LoginResponseErrorEntity {
  LoginErrorResponse({
      Error? error,}) : super(errorMsg: error!.message.toString()){
    _error = error;
}

  factory LoginErrorResponse.fromJson(dynamic json) {
    return LoginErrorResponse(
      error: Error.fromJson(json['error'])
    );
  }

  Error? _error;

  Error? get error => _error;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    return map;
  }

}

/// code : 400
/// message : "EMAIL_NOT_FOUND"
/// errors : [{"message":"EMAIL_NOT_FOUND","domain":"global","reason":"invalid"}]

class Error {
  Error({
      String? message,
      List<Errors>? errors,}){

    _message = message;
    _errors = errors;
}

  Error.fromJson(dynamic json) {

    _message = json['message'];
    if (json['errors'] != null) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors?.add(Errors.fromJson(v));
      });
    }
  }

  String? _message;
  List<Errors>? _errors;

  String? get message => _message;
  List<Errors>? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_errors != null) {
      map['errors'] = _errors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// message : "EMAIL_NOT_FOUND"
/// domain : "global"
/// reason : "invalid"

class Errors {
  Errors({
      String? message, 
      String? domain, 
      String? reason,}){
    _message = message;
    _domain = domain;
    _reason = reason;
}

  Errors.fromJson(dynamic json) {
    _message = json['message'];
    _domain = json['domain'];
    _reason = json['reason'];
  }
  String? _message;
  String? _domain;
  String? _reason;

  String? get message => _message;
  String? get domain => _domain;
  String? get reason => _reason;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['message'] = _message;
    map['domain'] = _domain;
    map['reason'] = _reason;
    return map;
  }

}