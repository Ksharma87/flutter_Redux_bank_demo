// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/utils/view/loading_view/loading_progress_dialog.dart' as _i5;
import '../data/data_sources/remote/api_services.dart' as _i3;
import '../data/data_sources/remote/rest_api.dart' as _i10;
import '../data/data_sources/remote/rest_api_config.dart' as _i8;
import '../data/repositories/accounts/accounts_repository_impl.dart' as _i12;
import '../data/repositories/auth/auth_repository_impl.dart' as _i15;
import '../data/repositories/payment/payment_repository_impl.dart' as _i18;
import '../data/repositories/profile/profile_repository_impl.dart' as _i21;
import '../domain/repositories/accounts/accounts_repository.dart' as _i11;
import '../domain/repositories/auth/auth_repository.dart' as _i14;
import '../domain/repositories/payment/payment_repository.dart' as _i17;
import '../domain/repositories/profile/profile_repository.dart' as _i20;
import '../domain/useCase/accounts/accounts_useCase.dart' as _i13;
import '../domain/useCase/auth/auth_useCase.dart' as _i16;
import '../domain/useCase/payment/payment_useCase.dart' as _i19;
import '../domain/useCase/profile/profile_useCase.dart' as _i22;
import '../preferences/preferences_contents.dart' as _i6;
import '../preferences/preferences_manager.dart' as _i7;
import '../services/balance_service.dart' as _i4;
import '../utils/validation.dart' as _i9;

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
  gh.singleton<_i4.BalanceUpdateService>(_i4.BalanceUpdateService());
  gh.factory<_i5.LoadingProgressDialog>(() => _i5.LoadingProgressDialog());
  gh.singleton<_i6.PreferencesContents>(_i6.PreferencesContents());
  gh.factory<_i7.PreferencesManager>(() => _i7.PreferencesManager());
  gh.factory<_i8.RestApiConfig>(() => _i8.RestApiConfig());
  gh.factory<_i9.Validation>(() => _i9.Validation());
  gh.factory<_i10.RestApi>(
      () => _i10.RestApi(restApiConfig: gh<_i8.RestApiConfig>()));
  gh.factory<_i11.AccountsRepository>(
      () => _i12.AccountsRepositoryImpl(restApi: gh<_i10.RestApi>()));
  gh.factory<_i13.AccountsUseCase>(() =>
      _i13.AccountsUseCase(accountsRepository: gh<_i11.AccountsRepository>()));
  gh.factory<_i14.AuthRepository>(
      () => _i15.AuthRepositoryImpl(restApi: gh<_i10.RestApi>()));
  gh.factory<_i16.AuthUseCase>(
      () => _i16.AuthUseCase(authRepository: gh<_i14.AuthRepository>()));
  gh.factory<_i17.PaymentRepository>(
      () => _i18.PaymentRepositoryImpl(restApi: gh<_i10.RestApi>()));
  gh.factory<_i19.PaymentUseCase>(() =>
      _i19.PaymentUseCase(paymentRepository: gh<_i17.PaymentRepository>()));
  gh.factory<_i20.ProfileRepository>(
      () => _i21.ProfileRepositoryImpl(restApi: gh<_i10.RestApi>()));
  gh.factory<_i22.ProfileUseCase>(() =>
      _i22.ProfileUseCase(profileRepository: gh<_i20.ProfileRepository>()));
  return getIt;
}
