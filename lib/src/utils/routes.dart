import 'package:awesome_app/src/features/authentication/presentation/login_screen.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/features/home/presentation/home_detail.dart';
import 'package:awesome_app/src/features/home/presentation/home_screen.dart';
import 'package:awesome_app/src/features/general/presentation/empty_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const loginScreen = 'login';
  static const homeScreen = "home";
  static const detailScreen = "detail";
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(), settings: settings);
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);
      case AppRoutes.detailScreen:
        return MaterialPageRoute(
            builder: (_) => HomeDetail(
                  photo: args as Photo,
                ),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const EmptyScreen(), settings: settings);
    }
  }
}
