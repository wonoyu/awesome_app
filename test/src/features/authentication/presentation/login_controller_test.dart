import 'package:awesome_app/src/features/authentication/presentation/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late LoginController controller;
  // initial setup
  setUp(() {
    authRepository = MockAuthRepository();
    controller = LoginController(authRepository: authRepository);
  });

  group('LoginController', () {
    test('initial state is AsyncData', () {
      verifyNever(authRepository.logout);
      expect(controller.debugState, const AsyncData<void>(null));
    });

    test('login with email password filled success', () async {
      // setup
      when(() => authRepository.login('username', 'password'))
          .thenAnswer((_) => Future.value());
      // run
      expectLater(
        controller.stream,
        emitsInOrder(const [
          AsyncLoading<void>(),
          AsyncData<void>(null),
        ]),
      );
      await controller.login('username', 'password');
      // verify
      verify(() => controller.login('username', 'password')).called(1);
    }, timeout: const Timeout(Duration(milliseconds: 500)));

    test('loginAnonymously success', () async {
      // setup
      when(authRepository.loginAnonymous).thenAnswer((_) => Future.value());
      // run
      await controller.loginAnonymously();
      // verify
      verify(authRepository.loginAnonymous).called(1);
      expect(controller.debugState, const AsyncData<void>(null));
    });

    test(
      'loginAnonymously success',
      () async {
        // setup
        when(authRepository.loginAnonymous).thenAnswer((_) => Future.value());
        // run
        expectLater(
          controller.stream,
          emitsInOrder(const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]),
        );
        await controller.loginAnonymously();
        // verify
        verify(authRepository.loginAnonymous).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'login with email password filled failure',
      () async {
        // setup
        final exception = Exception('Connection failed');
        when(() => authRepository.login('username', 'password'))
            .thenThrow(exception);
        // run
        expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value, isA<AsyncError<void>>());
              return true;
            })
          ]),
        );
        await controller.login('username', 'password');
        // verify
        verify(() => authRepository.login('username', 'password')).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'loginAnonymously failure',
      () async {
        // setup
        final exception = Exception('Connection failed');
        when(authRepository.loginAnonymous).thenThrow(exception);
        // run
        expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value, isA<AsyncError<void>>());
              return true;
            })
          ]),
        );
        await controller.loginAnonymously();
        // verify
        verify(authRepository.loginAnonymous).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );
  });
}
