// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/utils/loading_view/loading_progress_dialog.dart' as _i4;
import '../data/data_sources/remote/api_services.dart' as _i3;
import '../data/data_sources/remote/rest_api.dart' as _i8;
import '../data/data_sources/remote/rest_api_config.dart' as _i6;
import '../data/repositories/auth/auth_repository_impl.dart' as _i10;
import '../data/repositories/profile/profile_repository_impl.dart' as _i13;
import '../domain/repositories/auth/auth_repository.dart' as _i9;
import '../domain/repositories/profile/profile_repository.dart' as _i12;
import '../domain/useCase/auth/auth_useCase.dart' as _i11;
import '../domain/useCase/profile/profile_useCase.dart' as _i14;
import '../preferences/preferences_manager.dart' as _i5;
import '../utils/validation.dart' as _i7;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ApiServices>(() => _i3.ApiServices());
  gh.factory<_i4.LoadingProgressDialog>(() => _i4.LoadingProgressDialog());
  gh.factory<_i5.PreferencesManager>(() => _i5.PreferencesManager());
  gh.factory<_i6.RestApiConfig>(() => _i6.RestApiConfig());
  gh.factory<_i7.Validation>(() => _i7.Validation());
  gh.factory<_i8.RestApi>(
      () => _i8.RestApi(restApiConfig: gh<_i6.RestApiConfig>()));
  gh.factory<_i9.AuthRepository>(
      () => _i10.AuthRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i11.AuthUseCase>(
      () => _i11.AuthUseCase(authRepository: gh<_i9.AuthRepository>()));
  gh.factory<_i12.ProfileRepository>(
      () => _i13.ProfileRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i14.ProfileUseCase>(() =>
      _i14.ProfileUseCase(profileRepository: gh<_i12.ProfileRepository>()));
  return getIt;
}
