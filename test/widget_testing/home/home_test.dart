import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../main_config.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  final MainConfig mainConfig = MainConfig();
  final HomePage page = HomePage();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testWidgets('Home UI welcome text testing', (WidgetTester tester) async {
    Widget mainView = await mainConfig.mainAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var welcomeText =
        find.byKey(const Key(ViewKeysConfig.welcomeBankTextHomeKey));
    var text = welcomeText.evaluate().single.widget as Text;
    expect(welcomeText, findsOneWidget);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Home UI Login action testing', (WidgetTester tester) async {
    Widget mainView = await mainConfig.mainAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var elevatedButtonLogin =
        find.byKey(const Key(ViewKeysConfig.loginButtonHomeKey));
    await tester.tap(elevatedButtonLogin);
  });

  testWidgets('Home UI Create account action testing',
      (WidgetTester tester) async {
    Widget mainView = await mainConfig.mainAppConfigSetup(tester, page);
    await tester.pumpWidget(mainView);

    await tester.pumpAndSettle();
    var elevatedButtonCreateAccountButton =
        find.byKey(const Key(ViewKeysConfig.createAccountButtonHomeKey));
    await tester.tap(elevatedButtonCreateAccountButton);
  });
}
