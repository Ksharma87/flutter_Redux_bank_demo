import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/data/models/auth/login_request.dart';
import 'package:flutter_redux_bank/data/models/profile/update_profile_request.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/auth/login_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/auth/auth_repository.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final RestApi restApi;

  ProfileRepositoryImpl({required this.restApi});

  @override
  Future<bool> doUpdateProfile(
      String idToken, String displayName, String photoUrl) async {
    return await restApi.updateProfile(UpdateProfileRequest(
        idToken: idToken, displayName: displayName, photoUrl: photoUrl));
  }

  @override
  Future<bool> doGetProfile(String idToken) async {
    return await restApi.getProfile(idToken);
  }
}
