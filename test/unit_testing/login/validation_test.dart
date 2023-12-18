import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/common/types/user_details_type.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../configuration/material_app_config.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testWidgets('Auth and details screens testing', (WidgetTester tester) async {
    MaterialApp mainApp = await materialAppSetup(tester, const Scaffold());
    await tester.pumpWidget(mainApp);

    Validation validation = getIt<Validation>();
    String? email = "tushar.chinu82@gmail";
    expect(validation.validateEmail(email), "Enter a valid email address");

    email = "tushar.chinu82@gmail.com";
    expect(validation.validateEmail(email), null);

    email = "";
    expect(validation.validateEmail(email), "Please enter email address");

    // null return valid  Password
    String? password = "Tkaushik@786";
    expect(validation.validatePassword(password), null);

    password = "Tkau@786";
    expect(validation.validatePassword(password), null);

    password = "Tka@786";
    expect(validation.validatePassword(password), 'Enter valid password');

    password = "";
    expect(validation.validatePassword(password), 'Please enter password');

    String? name = "";
    expect(validation.validateName(name, UserDetailsType.FIRSTNAME.name),
        'Please enter first name');

    name = "tushar789";
    expect(validation.validateName(name, UserDetailsType.FIRSTNAME.name),
        'Please enter valid first name');

    name = "tushar";
    expect(validation.validateName(name, UserDetailsType.FIRSTNAME.name), null);

    String mobile = "9958208726";
    expect(validation.validateMobile(mobile), null);

    mobile = "+91-9958208726";
    expect(
        validation.validateMobile(mobile), 'Please enter valid mobile number');
  });
}
