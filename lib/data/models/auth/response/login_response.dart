import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';

/// kind : "identitytoolkit#VerifyPasswordResponse"
/// localId : "2i3myABflFclBIG2hfn5KPtDsEQ2"
/// email : "tushar.kaushik786@gmail.com"
/// displayName : ""
/// idToken : "eyJhbGciOiJSUzI1NiIsImtpZCI6ImhBeWs4QSJ9.eyJpc3MiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGUuY29tLyIsImF1ZCI6ImZpci1nYmFuayIsImlhdCI6MTcwMDM0NTE1MywiZXhwIjoxNzAxNTU0NzUzLCJ1c2VyX2lkIjoiMmkzbXlBQmZsRmNsQklHMmhmbjVLUHREc0VRMiIsImVtYWlsIjoidHVzaGFyLmthdXNoaWs3ODZAZ21haWwuY29tIiwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIiwidmVyaWZpZWQiOmZhbHNlfQ.DecU6E3WTuTtDa3I4rcsz7jckLX6wwu-WxfQGoPt8f8ELqHUUPoH0VbNvVpDezd0X9cpYOHg7asdEyZtJ1mIqCh57JBcUX6GKBiOdWHCZlUaP7gW62NLyPOu1R-a4iw7azTlskruV85mI0WuhBxDGEykuniJ0CeyjQ6BLz_4mxq-TruA4D75XvT9jhgbYm_ea77iy64UAYX6Hq5v0PuDjLPhSo12furKNrA4UnrG9_BPGol7WRLUgRyUxTAncBRjVzKySpcryTtxtPipQmgIe00_N-ALYQuqqldAWJD0WPQ7GlAxgnp9BzkDs61OPS0waE5yZTkHsZ2O_pl0-8ZwYA"

class LoginResponse extends LoginResponseEntity {
  LoginResponse({
    required String kind,
    required String localId,
    required String email,
    required String displayName,
    required String idToken,
  }) : super(
          kind: kind,
          localId: localId,
          email: email,
          displayName: displayName,
          idToken: idToken,
        ) {
    _kind = kind;
    _localId = localId;
    _email = email;
    _displayName = displayName;
    _idToken = idToken;
  }

  factory LoginResponse.fromJson(dynamic json) {
    String? _kind = json['kind'];
    String? _localId = json['localId'];
    String? _email = json['email'];
    String? _idToken = json['idToken'];
    String _displayName = json['displayName'] ?? '';

    return LoginResponse(
        kind: _kind!,
        localId: _localId!,
        email: _email!,
        displayName: _displayName,
        idToken: _idToken!);
  }

  late String _kind;
  late String _localId;
  late String _email;
  late String _displayName;
  late String _idToken;

  @override
  String get kind => _kind;

  @override
  String get localId => _localId;

  @override
  String get email => _email;

  @override
  String get displayName => _displayName;

  @override
  String get idToken => _idToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['localId'] = _localId;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['idToken'] = _idToken;
    return map;
  }
}
