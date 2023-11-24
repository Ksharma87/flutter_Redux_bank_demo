class LoginRequest {
  String email;
  String password;

  LoginRequest({this.email = "", this.password = ""});

  @override
  String toString() {
    return "{\"email\": \"$email\", \"password\": \"$password\"}";
  }
}
