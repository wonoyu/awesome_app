import 'package:awesome_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:awesome_app/src/utils/routes.dart';
import 'package:awesome_app/src/utils/themes.dart';
import 'package:flutter/material.dart';

class AwesomeApp extends StatelessWidget {
  const AwesomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome App',
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
      theme: themeData,
      home: const AuthScreen(),
    );
  }
}
