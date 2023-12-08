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
import '../data/repositories/accounts/accounts_repository_impl.dart' as _i10;
import '../data/repositories/auth/auth_repository_impl.dart' as _i13;
import '../data/repositories/payment/payment_repository_impl.dart' as _i16;
import '../data/repositories/profile/profile_repository_impl.dart' as _i19;
import '../domain/repositories/accounts/accounts_repository.dart' as _i9;
import '../domain/repositories/auth/auth_repository.dart' as _i12;
import '../domain/repositories/payment/payment_repository.dart' as _i15;
import '../domain/repositories/profile/profile_repository.dart' as _i18;
import '../domain/useCase/accounts/accounts_useCase.dart' as _i11;
import '../domain/useCase/auth/auth_useCase.dart' as _i14;
import '../domain/useCase/payment/payment_useCase.dart' as _i17;
import '../domain/useCase/profile/profile_useCase.dart' as _i20;
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
  gh.factory<_i9.AccountsRepository>(
      () => _i10.AccountsRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i11.AccountsUseCase>(() =>
      _i11.AccountsUseCase(accountsRepository: gh<_i9.AccountsRepository>()));
  gh.factory<_i12.AuthRepository>(
      () => _i13.AuthRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i14.AuthUseCase>(
      () => _i14.AuthUseCase(authRepository: gh<_i12.AuthRepository>()));
  gh.factory<_i15.PaymentRepository>(
      () => _i16.PaymentRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i17.PaymentUseCase>(() =>
      _i17.PaymentUseCase(paymentRepository: gh<_i15.PaymentRepository>()));
  gh.factory<_i18.ProfileRepository>(
      () => _i19.ProfileRepositoryImpl(restApi: gh<_i8.RestApi>()));
  gh.factory<_i20.ProfileUseCase>(() =>
      _i20.ProfileUseCase(profileRepository: gh<_i18.ProfileRepository>()));
  return getIt;
}
