import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/app/utils/view_keys/view_keys_config.dart';
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
  final HomePage page = HomePage();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testGoldenScreensWidgets(AppRouter.HOME_PAGE, (tester) async {
    await loadAppFonts();
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidgetBuilder(mainView);
    await multiScreenGolden(tester,
        '$rootScreenShotPath${AppRouter.HOME_PAGE}/${responsiveVariant.currentValue!.name}${AppRouter.HOME_PAGE}',
        devices: [
          Device(
              devicePixelRatio: responsiveVariant.currentValue!.pixelDensity,
              size: Size(responsiveVariant.currentValue!.width,
                  responsiveVariant.currentValue!.height),
              name: responsiveVariant.currentValue!.name)
        ]);
  }, goldenCallback: (tester) async {
    final matcher = matchesGoldenFile(
        '$rootScreenShotPath${AppRouter.HOME_PAGE}/${responsiveVariant.currentValue!.name}${AppRouter.HOME_PAGE}.${responsiveVariant.currentValue!.name}.png');
    await expectLater(
        find.byKey(const Key(ViewKeysConfig.loginButtonHomeKey)), matcher);
  });
}
