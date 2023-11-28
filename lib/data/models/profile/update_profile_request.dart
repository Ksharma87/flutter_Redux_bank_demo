class UpdateProfileRequest {
  String idToken;
  String displayName;
  String photoUrl;

  UpdateProfileRequest({this.idToken = "", this.displayName = "", this.photoUrl = ""});

  @override
  String toString() {
    return "{\"idToken\": \"$idToken\", \"displayName\": \"$displayName\",  \"photoUrl\": \"$photoUrl\"}";
  }
}
