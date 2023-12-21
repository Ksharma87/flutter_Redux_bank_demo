import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/di/injection.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'my_application/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  PreferencesManager.initManager();
  runApp(const MyApp());
}
