class UpdateProfileRequest {
  String email;
  String firstName;
  String lastName;
  String mobileNumber;
  String gender;

  UpdateProfileRequest(
      {this.email = "",
      this.firstName = "",
      this.lastName = "",
      this.mobileNumber = "",
      this.gender = ""});

  @override
  String toString() {
    return "{\"email\": \"$email\", \"firstName\": \"$firstName\",  \"lastName\": \"$lastName\", \"mobileNumber\": \"$mobileNumber\",  \"gender\": \"$gender\"}";
  }
}
