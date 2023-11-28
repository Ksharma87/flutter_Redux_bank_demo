abstract class ProfileRepository {

  Future<void> doUpdateProfile(String idToken, String displayName, String photoUrl);

}