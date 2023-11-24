import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/utils/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  group("email validation test group", () {

    test('Email Validation test', () {
      Validation validation = getIt<Validation>();
      String? email = "tushar.chinu82@gmail.com";
      expect(validation.validateEmail(email), null);
    });

    test('Email Validation test', () {
      Validation validation = getIt<Validation>();
      String? email = "tushar.chinu82@gmail";
      expect(validation.validateEmail(email), "Enter a valid email address");
    });

    test('empty email validation test', () {
      Validation validation = getIt<Validation>();
      String? email = "";
      expect(validation.validateEmail(email), "Please enter email address");
    });

  });

  group("Password validation test group", () {

    test('Password Validation test', () {
      Validation validation = getIt<Validation>();
      String? password = "Tkaushik@786";
      expect(validation.validatePassword(password), null);
    });

    test('Password length 8 Validation test', () {
      Validation validation = getIt<Validation>();
      String? password = "Tkau@786";
      expect(validation.validatePassword(password), null);
    });

    test('Password length less 8 Validation test', () {
      Validation validation = getIt<Validation>();
      String? password = "Tka@786";
      expect(validation.validatePassword(password), 'Enter valid password');
    });

    test('Password without special char Validation test', () {
      Validation validation = getIt<Validation>();
      String? password = "Tka786";
      expect(validation.validatePassword(password), 'Enter valid password');
    });

    test('Password empty Validation test', () {
      Validation validation = getIt<Validation>();
      String? password = "";
      expect(validation.validatePassword(password), 'Please enter password');
    });


  });
}
