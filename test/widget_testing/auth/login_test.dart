import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../configuration/material_app_config.dart';
import '../../configuration/wrapper_testWidgets_responsive.dart';

void main() {
  final LoginPage loginPage = LoginPage(authType: AuthType.LOGIN.name);
  final LoginPage createPage =
  LoginPage(authType: AuthType.CREATE_ACCOUNT.name);
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    configureDependencies();
  });

  testResponsiveWidgets('Auth UI Login button text testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);

        await tester.pumpAndSettle();
        var loginText = find.byKey(const Key(ViewKeysConfig.loginTextLoginKey));
        expect(loginText, findsOneWidget);

        var loginTextWidget = loginText
            .evaluate()
            .single
            .widget as Text;
        expect(loginTextWidget.data,
            AppLocalization.localizations!.login.toUpperCase());
        expect(loginTextWidget.style?.color, Colors.white);
      }, skip: false);

  testResponsiveWidgets('Auth UI Create button text testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, createPage);
        await tester.pumpWidget(mainView);

        await tester.pumpAndSettle();
        var createText = find.byKey(
            const Key(ViewKeysConfig.loginTextLoginKey));
        expect(createText, findsOneWidget);

        var loginTextWidget = createText
            .evaluate()
            .single
            .widget as Text;
        expect(loginTextWidget.data,
            AppLocalization.localizations!.createAccount.toUpperCase());
        expect(loginTextWidget.style?.color, Colors.white);
      }, skip: false);

  testResponsiveWidgets('Auth UI Login button on click invalid Email testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);

        await tester.pumpAndSettle();
        var emailField = find.byKey(const Key(ViewKeysConfig.emailIdTextField));
        var passwordField = find.byKey(
            const Key(ViewKeysConfig.passwordTextField));
        var loginButton = find.byType(ElevatedButton);

        await tester.enterText(emailField, "tushar@mailcom");
        await tester.enterText(passwordField, "");
        await tester.tap(loginButton);
        await tester.pump();
        expect(find.text(AppLocalization.localizations!.emailInvalidation), findsOneWidget);
        }, skip: false);

  testResponsiveWidgets('Auth UI Login button on click empty Password testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);

        await tester.pumpAndSettle();
        var emailField = find.byKey(const Key(ViewKeysConfig.emailIdTextField));
        var passwordField = find.byKey(
            const Key(ViewKeysConfig.passwordTextField));
        var loginButton = find.byType(ElevatedButton);

        await tester.enterText(emailField, "tushar@mail.com");
        await tester.enterText(passwordField, "");
        await tester.tap(loginButton);
        await tester.pump();
        expect(find.text(AppLocalization.localizations!.passwordEmpty), findsOneWidget);
      }, skip: false);

  testResponsiveWidgets('Auth UI Login button on click invalid Password testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);

        await tester.pumpAndSettle();
        var emailField = find.byKey(const Key(ViewKeysConfig.emailIdTextField));
        var passwordField = find.byKey(
            const Key(ViewKeysConfig.passwordTextField));
        var loginButton = find.byType(ElevatedButton);

        await tester.enterText(emailField, "tushar@mail.com");
        await tester.enterText(passwordField, "Tkaushik");
        await tester.tap(loginButton);
        await tester.pump();
        expect(find.text(AppLocalization.localizations!.passwordInvalidation), findsOneWidget);
      }, skip: false);

  testResponsiveWidgets('Auth UI Login AppBar Back button on click testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key(ViewKeysConfig.appBarBackArrowKey)));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsNothing);
      }, skip: false);

  testResponsiveWidgets('Auth UI Login AppBar Title testing',
          (WidgetTester tester) async {
        Widget mainView = await materialAppConfigSetup(tester, loginPage);
        await tester.pumpWidget(mainView);
        await tester.pumpAndSettle();
        var appbarTitle = find.text('${AppLocalization.localizations!.noida} ${AppLocalization.localizations!.bank}'); //find.ancestor(of: find.byKey(Key("appbar")), matching: find.text('${AppLocalization.localizations!.noida} ${AppLocalization.localizations!.bank}'));
        var appbarTitleText = appbarTitle
            .evaluate()
            .single
            .widget as Text;
        expect(appbarTitleText.style?.color, Colors.white);
      }, skip: false);

}
