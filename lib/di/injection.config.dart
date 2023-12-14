// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/logout/logout_dialogs.dart' as _i6;
import '../app/utils/view/loading_view/loading_progress_dialog.dart' as _i5;
import '../data/data_sources/remote/api_services.dart' as _i3;
import '../data/data_sources/remote/rest_api.dart' as _i11;
import '../data/data_sources/remote/rest_api_config.dart' as _i9;
import '../data/repositories/accounts/accounts_repository_impl.dart' as _i13;
import '../data/repositories/auth/auth_repository_impl.dart' as _i16;
import '../data/repositories/passbook/passbook_repository_impl.dart' as _i19;
import '../data/repositories/payment/payment_repository_impl.dart' as _i22;
import '../data/repositories/profile/profile_repository_impl.dart' as _i25;
import '../domain/repositories/accounts/accounts_repository.dart' as _i12;
import '../domain/repositories/auth/auth_repository.dart' as _i15;
import '../domain/repositories/passbook/passbook_repository.dart' as _i18;
import '../domain/repositories/payment/payment_repository.dart' as _i21;
import '../domain/repositories/profile/profile_repository.dart' as _i24;
import '../domain/useCase/accounts/accounts_useCase.dart' as _i14;
import '../domain/useCase/auth/auth_useCase.dart' as _i17;
import '../domain/useCase/passbook/passbook_useCase.dart' as _i20;
import '../domain/useCase/payment/payment_useCase.dart' as _i23;
import '../domain/useCase/profile/profile_useCase.dart' as _i26;
import '../preferences/preferences_contents.dart' as _i7;
import '../preferences/preferences_manager.dart' as _i8;
import '../services/balance_service.dart' as _i4;
import '../utils/validation.dart' as _i10;

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
  gh.singleton<_i6.LogoutDialogs>(_i6.LogoutDialogs());
  gh.singleton<_i7.PreferencesContents>(_i7.PreferencesContents());
  gh.factory<_i8.PreferencesManager>(() => _i8.PreferencesManager());
  gh.factory<_i9.RestApiConfig>(() => _i9.RestApiConfig());
  gh.factory<_i10.Validation>(() => _i10.Validation());
  gh.factory<_i11.RestApi>(
      () => _i11.RestApi(restApiConfig: gh<_i9.RestApiConfig>()));
  gh.factory<_i12.AccountsRepository>(
      () => _i13.AccountsRepositoryImpl(restApi: gh<_i11.RestApi>()));
  gh.factory<_i14.AccountsUseCase>(() =>
      _i14.AccountsUseCase(accountsRepository: gh<_i12.AccountsRepository>()));
  gh.factory<_i15.AuthRepository>(
      () => _i16.AuthRepositoryImpl(restApi: gh<_i11.RestApi>()));
  gh.factory<_i17.AuthUseCase>(
      () => _i17.AuthUseCase(authRepository: gh<_i15.AuthRepository>()));
  gh.factory<_i18.PassbookRepository>(
      () => _i19.PassbookRepositoryImpl(restApi: gh<_i11.RestApi>()));
  gh.factory<_i20.PassbookUseCase>(() =>
      _i20.PassbookUseCase(passbookRepository: gh<_i18.PassbookRepository>()));
  gh.factory<_i21.PaymentRepository>(
      () => _i22.PaymentRepositoryImpl(restApi: gh<_i11.RestApi>()));
  gh.factory<_i23.PaymentUseCase>(() =>
      _i23.PaymentUseCase(paymentRepository: gh<_i21.PaymentRepository>()));
  gh.factory<_i24.ProfileRepository>(
      () => _i25.ProfileRepositoryImpl(restApi: gh<_i11.RestApi>()));
  gh.factory<_i26.ProfileUseCase>(() =>
      _i26.ProfileUseCase(profileRepository: gh<_i24.ProfileRepository>()));
  return getIt;
}
