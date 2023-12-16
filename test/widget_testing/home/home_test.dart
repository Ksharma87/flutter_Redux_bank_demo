import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/dashboard/dashboard_page.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home UI testing', (WidgetTester tester) async {
    const size = Size(393, 852);
    await tester.binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 3;
    tester.view.platformDispatcher.textScaleFactorTestValue = 1;

    const Size designSize = Size(360, 690);
    const Size initialSize = designSize;
    const Size biggerSize = Size(480, 920);
    const Size smallerSize = Size(300, 560);

    // We'll use MediaQuery to simulate diffrent screen sizes
    MediaQueryData currentData = const MediaQueryData(size: size);
    const MediaQueryData biggerData = MediaQueryData(size: biggerSize);
    const MediaQueryData smallerData = MediaQueryData(size: smallerSize);

    tester.view.padding = const FakeViewPadding(bottom: 0, top: 0);
    tester.view.systemGestureInsets = const FakeViewPadding(bottom: 0, top: 0);
    tester.view.viewInsets = const FakeViewPadding(bottom: 0, top: 0);
    tester.view.viewPadding = const FakeViewPadding(bottom: 0, top: 0);

    await tester.pumpWidget(MediaQuery(
      data: currentData,
      child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: designSize,
          builder: (_, child) {
            return StoreProvider(
                store: store,
                child: MaterialApp(
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'), // English
                  ],
                  home: HomePage(),
                  theme: ThemeData(
                      primaryColor: ColorsTheme.primaryColor,
                      primaryColorDark: ColorsTheme.secondColor),
                  navigatorKey: NavigatorHolder.navigatorKey,
                ));
          }),
    ));

    await tester.pumpAndSettle();
    var elevatedButtonLogin = find.byKey(const Key("login_Btn_key"));
    await tester.pump();
    // print(elevatedButtonLogin);
    //expect(elevatedButtonLogin, findsNWidgets(2));
  });
}
