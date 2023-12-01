import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' as result_type;

@injectable
class ProfileUseCase {
  late ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<bool> invokeUpdateProfile(String idToken, String displayName, String photoUrl) async {
    return await profileRepository.doUpdateProfile(idToken, displayName, photoUrl);
  }

  Future<bool> invokeGetProfile(String idToken) async {
    return await profileRepository.doGetProfile(idToken);
  }

}
