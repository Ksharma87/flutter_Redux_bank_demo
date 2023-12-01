abstract class ProfileRepository {

  Future<bool> doUpdateProfile(String idToken, String displayName, String photoUrl);

  Future<bool> doGetProfile(String idToken);

}