import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/app/home/home_page.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../../configuration/device_config.dart';
import '../../configuration/material_app_config.dart';
import '../../configuration/screen_size.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  final HomePage page = HomePage();

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testGoldens('Home Page Screen', (tester) async {
    await loadAppFonts();
    responsiveVariant.setUp(iPhone15ProMax);
    Widget mainView = await materialAppConfigSetup(tester, page);
    await tester.pumpWidgetBuilder(mainView);
    await multiScreenGolden(tester, '../../../../screenShots/home/home_page', devices: devices);
    await expectLater(find.byWidget(mainView), matchesGoldenFile('../../../../screenShots/home/home_page.iPhone15ProMax.png'));
  });
}
