import 'package:awesome_app/src/app.dart';
import 'package:awesome_app/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider
        .overrideWithValue(SharedPreferencesProvider(sharedPreferences)),
  ], child: const AwesomeApp()));
}
