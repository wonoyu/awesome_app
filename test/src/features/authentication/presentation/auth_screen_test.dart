import 'package:flutter_test/flutter_test.dart';

import '../auth_tester.dart';

void main() {
  group('AuthScreen', () {
    testWidgets('login anonymous and logout', (tester) async {
      final authTester = AuthTester(tester);
      await authTester.pumpApp();
      await authTester.loginAnonymously();
      authTester.expectHomeScreen();
      await authTester.logout();
      authTester.expectLoginScreen();
    });

    testWidgets('login and logout', (tester) async {
      final authTester = AuthTester(tester);
      await authTester.pumpApp();
      await authTester.login();
      authTester.expectHomeScreen();
      await authTester.logout();
      authTester.expectLoginScreen();
    });
  });
}
