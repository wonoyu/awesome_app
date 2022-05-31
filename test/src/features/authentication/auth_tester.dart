import 'package:awesome_app/src/app.dart';
import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthTester {
  AuthTester(this.tester);
  final WidgetTester tester;

  Future<void> pumpApp(
      {DummyAuthRepository? authRepository, bool settle = true}) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [
        if (authRepository != null)
          authRepositoryProvider.overrideWithValue(authRepository)
      ], child: const AwesomeApp()),
    );
    if (settle) await tester.pumpAndSettle();
  }

  Future<void> login() async {
    final inputUsername = find.byKey(const Key('username'));
    final inputPassword = find.byKey(const Key('password'));
    final button = find.text('Login');
    expect(inputUsername, findsOneWidget);
    expect(inputPassword, findsOneWidget);
    expect(button, findsOneWidget);
    await tester.enterText(inputUsername, 'username');
    await tester.enterText(inputPassword, 'password');
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Future<void> loginAnonymously() async {
    final button = find.text('Login as Guest');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Future<void> logout() async {
    final button = find.byIcon(Icons.logout_outlined);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
  }

  void expectHomeScreen() {
    final appbar = find.text('Home Screen');
    expect(appbar, findsOneWidget);
  }

  void expectLoginScreen() {
    final finder = find.text('Login');
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
