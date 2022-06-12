import 'package:awesome_app/src/app.dart';
import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import '../../../../lib/src/features/home/data/home_repository_test.dart';

class AuthTester {
  AuthTester(this.tester);
  final WidgetTester tester;

  Future<void> pumpLoginScreen({
    DummyAuthRepository? authRepository,
    MockHomeRepository? mockHomeRepository,
    bool settle = true,
  }) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [
        if (authRepository != null)
          authRepositoryProvider.overrideWithValue(authRepository),
        if (mockHomeRepository != null)
          curatedPhotosRepositoryProvider.overrideWithValue(mockHomeRepository),
        curatedPhotosStateChangesProvider
            .overrideWithProvider(fakeCuratedPhotosStateChangesProvider),
        pageRequestProvider.overrideWithValue(StateController(1)),
      ], child: const AwesomeApp()),
    );
    if (settle) await tester.pumpAndSettle();
  }

  // Future<void> pumpHomeScreen({
  //   required DummyAuthRepository authRepository,
  //   required MockHomeRepository mockHomeRepository,
  //   bool settle = true,
  // }) async {
  //   await tester.pumpWidget(
  //     ProviderScope(
  //       overrides: [
  //         authRepositoryProvider.overrideWithValue(authRepository),
  // curatedPhotosRepositoryProvider.overrideWithValue(mockHomeRepository),
  // curatedPhotosStateChangesProvider
  //     .overrideWithProvider(fakeCuratedPhotosStateChangesProvider),
  // pageRequestProvider.overrideWithValue(StateController(1)),
  //       ],
  //       child: const HomeScreen(),
  //     ),
  //   );
  //   if (settle) await tester.pumpAndSettle();
  // }

  Future<void> login() async {
    final inputUsername = find.byKey(const Key('username'));
    final inputPassword = find.byKey(const Key('password'));
    final button = find.text('Login');
    expect(inputUsername, findsOneWidget);
    expect(inputPassword, findsOneWidget);
    expect(button, findsOneWidget);
    await tester.enterText(inputUsername, 'username');
    await tester.pumpAndSettle();
    await tester.enterText(inputPassword, 'password');
    await tester.pumpAndSettle();
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 3));
  }

  Future<void> loginAnonymously() async {
    final button = find.text('Login as Guest');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 3));
  }

  Future<void> logout() async {
    final button = find.byIcon(Icons.logout_outlined);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 3));
  }

  void expectHomeScreen() {
    final appbar = find.byType(NestedScrollView);
    expect(appbar, findsOneWidget);
  }

  void expectLoginScreen() {
    final finder = find.text('Login to your account');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlert() {
    final alert = find.text('Error');
    expect(alert, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final alert = find.text('Error');
    expect(alert, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final progress = find.byType(CircularProgressIndicator);
    expect(progress, findsOneWidget);
  }
}
