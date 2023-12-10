import 'package:flutter_redux_bank/data/models/profile/response/profile_response.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class ProfileUseCase {
  late ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<bool> invokeUpdateProfile(String email, String firstName, String lastName, String mobileNumber, String gender) async {
    return await profileRepository.doUpdateProfile(email, firstName, lastName, mobileNumber, gender);
  }

  Future<bool> invokeUpdateIdentity(String email, String mobileNumber, String uid) async {
    return await profileRepository.doUpdateIdentity(email, mobileNumber, uid);
  }

  Future<String?> invokeUniqueMobileNumberOrEmail(String mobileNumberOrEmail) async {
    return await profileRepository.doUniqueMobileNumberOrEmail(mobileNumberOrEmail);
  }

  Future<result_type.Result<ProfileResponseEntity, ProfileResponseErrorEntity>> invokeGetUserProfile(String idToken, String uid) async {
    final response = await profileRepository.doGetProfile(idToken, uid);
    return response;
  }

}
