import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_redux_bank/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, //
)
void configureDependencies() => $initGetIt(getIt);