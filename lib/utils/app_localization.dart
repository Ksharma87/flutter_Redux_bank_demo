import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class AppLocalization {
  static final AppLocalizations? localizations =
  AppLocalizations.of(NavigatorHolder.navigatorKey.currentContext!);
}
