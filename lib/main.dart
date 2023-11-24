import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/config/router/app_router_configuration.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/app/store.dart';
import 'package:flutter_redux_bank/utils/global_key_holder.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Redux - Dart',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
          ],
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          navigatorKey: NavigatorHolder.navigatorKey,
          scaffoldMessengerKey: GlobalKeyHolder.scaffoldMessengerKey,
          onGenerateRoute: _getRoute,
        ));
  }

  Route _getRoute(RouteSettings settings) {
    return AppRouterConfiguration.getRouteConfig(settings);
  }
}
