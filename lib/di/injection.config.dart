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
import '../data/data_sources/remote/rest_api.dart' as _i7;
import '../data/data_sources/remote/rest_api_config.dart' as _i5;
import '../data/repositories/auth/auth_repository_impl.dart' as _i9;
import '../domain/repositories/auth/auth_repository.dart' as _i8;
import '../domain/useCase/auth/auth_useCase.dart' as _i10;
import '../utils/validation.dart' as _i6;

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
  gh.factory<_i5.RestApiConfig>(() => _i5.RestApiConfig());
  gh.factory<_i6.Validation>(() => _i6.Validation());
  gh.factory<_i7.RestApi>(
      () => _i7.RestApi(restApiConfig: gh<_i5.RestApiConfig>()));
  gh.factory<_i8.AuthRepository>(
      () => _i9.AuthRepositoryImpl(restApi: gh<_i7.RestApi>()));
  gh.factory<_i10.AuthUseCase>(
      () => _i10.AuthUseCase(authRepository: gh<_i8.AuthRepository>()));
  return getIt;
}
