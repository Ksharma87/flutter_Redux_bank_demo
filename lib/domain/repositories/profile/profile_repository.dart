import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ProfileRepository {
  Future<bool> doUpdateProfile(String email, String firstName, String lastName,
      String mobileNumber, String gender, String uid);

  Future<bool> doUpdateIdentity(String email, String mobileNumber, String uid);

  Future<String?> doUniqueMobileNumberOrEmail(String mobileNumber);

  Future<Result<ProfileResponseEntity, ProfileResponseErrorEntity>>
      doGetProfile(String idToken, String uid);
}
