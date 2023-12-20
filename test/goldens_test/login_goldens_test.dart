import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/login/login_page.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
import 'package:flutter_redux_bank/common/types/auth_type.dart';
import 'package:flutter_redux_bank/config/router/app_router.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../configuration/material_app_config.dart';
import '../configuration/screen_size.dart';
import '../configuration/wrapper_testWidgets_responsive.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  final LoginPage page = LoginPage(authType: AuthType.LOGIN.name);
  const pageName = AppRouter.LOGIN_PAGE;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testGoldenScreensWidgets("Login screen golden screen shot", (tester) async {
    await loadAppFonts();
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidgetBuilder(mainView);
    await multiScreenGolden(tester,
        '$rootScreenShotPath$pageName/${responsiveVariant.currentValue!.name}$pageName',
        devices: [
          Device(
              devicePixelRatio: responsiveVariant.currentValue!.pixelDensity,
              size: Size(responsiveVariant.currentValue!.width,
                  responsiveVariant.currentValue!.height),
              name: responsiveVariant.currentValue!.name)
        ]);
  }, goldenCallback: (tester) async {
    final matcher = matchesGoldenFile(
        '$rootScreenShotPath$pageName/${responsiveVariant.currentValue!.name}$pageName.${responsiveVariant.currentValue!.name}.png');
    await expectLater(
        find.byKey(const Key(ViewKeysConfig.loginTextLoginKey)), matcher);
  });
}
