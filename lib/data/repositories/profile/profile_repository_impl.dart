import 'dart:convert';
import 'package:flutter_redux_bank/data/data_sources/remote/rest_api.dart';
import 'package:flutter_redux_bank/data/models/profile/update_profile_request.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_error_response_entity.dart';
import 'package:flutter_redux_bank/domain/entity/profile/profile_response_entity.dart';
import 'package:flutter_redux_bank/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final RestApi restApi;

  ProfileRepositoryImpl({required this.restApi});

  @override
  Future<bool> doUpdateProfile(String email, String firstName, String lastName,
      String mobileNumber, String gender) async {
    return await restApi.updateProfile(UpdateProfileRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        gender: gender));
  }

  @override
  Future<bool> doUpdateIdentity(
      String email, String mobileNumber, String uid) async {
    String emailEncode = base64.encode(utf8.encode(email));
    String mobileNumberEncode = base64.encode(utf8.encode(mobileNumber));
    String request = '{"$emailEncode": "$uid", "$mobileNumberEncode": "$uid"}';
    return await restApi.updateIdentity(request);
  }

  @override
  Future<Result<ProfileResponseEntity, ProfileResponseErrorEntity>>
      doGetProfile(String idToken, String uid) async {
    return await restApi.getProfile();
  }

  @override
  Future<bool> doUniqueMobileNumber(String mobileNumber) async {
    String mobileNumberEncode = base64.encode(utf8.encode(mobileNumber));
    return await restApi.getUniqueMobileNumberEmail(mobileNumberEncode);
  }
}
