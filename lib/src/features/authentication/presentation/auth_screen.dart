import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:awesome_app/src/features/authentication/presentation/login_screen.dart';
import 'package:awesome_app/src/features/general/presentation/loading_screen.dart';
import 'package:awesome_app/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.maybeWhen(
        data: (user) => user != null ? const HomeScreen() : const LoginScreen(),
        orElse: () => const LoadingScreen());
  }
}
