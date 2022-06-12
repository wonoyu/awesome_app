import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../auth_tester.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
        MaterialPageRoute(builder: (_) => const SizedBox.shrink()));
  });

  group('AuthScreen', () {
    late MockHomeRepository homeRepository;
    late DummyAuthRepository dummyAuthRepository;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      homeRepository = MockHomeRepository();
      dummyAuthRepository = DummyAuthRepository();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('login anonymous and logout', (tester) async {
      final authTester = AuthTester(tester);
      await authTester.pumpLoginScreen(
          authRepository: dummyAuthRepository,
          mockHomeRepository: homeRepository);
      await authTester.loginAnonymously();
      authTester.expectHomeScreen();
      await authTester.logout();
      authTester.expectLoginScreen();
    });

    testWidgets('login and logout', (tester) async {
      final authTester = AuthTester(tester);
      await authTester.pumpLoginScreen(
          authRepository: dummyAuthRepository,
          mockHomeRepository: homeRepository);
      await authTester.login();
      authTester.expectHomeScreen();
      await authTester.logout();
      authTester.expectLoginScreen();
    });
  });
}
