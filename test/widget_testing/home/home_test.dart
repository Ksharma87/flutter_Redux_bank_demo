import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../configuration/material_app_config.dart';
import '../../configuration/wrapper_testWidgets_responsive.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  final HomePage page = HomePage();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    configureDependencies();
  });

  testResponsiveWidgets('Home UI welcome text testing',
      (WidgetTester tester) async {
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var welcomeText =
        find.byKey(const Key(ViewKeysConfig.welcomeBankTextHomeKey));
    var text = welcomeText.evaluate().single.widget as Text;
    expect(welcomeText, findsOneWidget);
    expect(text.style?.color, Colors.white);
  }, goldenCallback: (size, tester) async {});

  testResponsiveWidgets('Home UI Login Text testing',
      (WidgetTester tester) async {
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var loginButtonText =
        find.byKey(const Key(ViewKeysConfig.loginTextHomeKey));
    var loginText = loginButtonText.evaluate().single.widget as Text;
    expect(loginText.data, AppLocalization.localizations!.login);
  });

  testResponsiveWidgets('Home UI Login action testing',
      (WidgetTester tester) async {
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var elevatedButtonLogin =
        find.byKey(const Key(ViewKeysConfig.loginButtonHomeKey));
    await tester.tap(elevatedButtonLogin);
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testResponsiveWidgets('Home UI Create Text testing',
      (WidgetTester tester) async {
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var createAccountTextKey =
        find.byKey(const Key(ViewKeysConfig.createAccountTextHomeKey));
    var createAccountText =
        createAccountTextKey.evaluate().single.widget as Text;
    expect(
        createAccountText.data, AppLocalization.localizations!.createAccount);
  });

  testResponsiveWidgets('Home UI Create account action testing',
      (WidgetTester tester) async {

    Widget mainView =
        await materialAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);
    var elevatedButtonCreateAccountButton =
        find.byKey(const Key(ViewKeysConfig.createAccountButtonHomeKey));
    await tester.pump();
    await tester.tap(elevatedButtonCreateAccountButton);
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
