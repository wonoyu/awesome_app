

// void main() {
//   late MockAuthRepository authRepository;
//   late HomeScreenController controller;

//   setUp(() {
//     authRepository = MockAuthRepository();
//     controller = HomeScreenController(authRepository: authRepository);
//   });

//   group('HomeScreenController (Logout)', () {
//     test('initial state is AsyncData', () {
//       verifyNever(() => authRepository.login('username', 'password'));
//       verifyNever(authRepository.loginAnonymous);
//       expect(controller.debugState, const AsyncData<void>(null));
//     });

//     test(
//       'logout success',
//       () async {
//         // setup
//         when(authRepository.logout).thenAnswer((_) => Future.value());
//         // run
//         expectLater(
//             controller.stream,
//             emitsInOrder([
//               const AsyncLoading<void>(),
//               const AsyncData<void>(null),
//             ]));
//         await controller.logout();
//         // verify
//         verify(authRepository.logout).called(1);
//       },
//       timeout: const Timeout(
//         Duration(milliseconds: 500),
//       ),
//     );

//     test(
//       'logout failure',
//       () async {
//         // setup
//         final exception = Exception('Connection failed');
//         when(authRepository.logout).thenThrow(exception);
//         // run
//         expectLater(
//             controller.stream,
//             emitsInOrder([
//               const AsyncLoading<void>(),
//               predicate<AsyncValue<void>>((value) {
//                 expect(value, isA<AsyncError<void>>());
//                 return true;
//               }),
//             ]));
//         await controller.logout();
//         // verify
//         verify(authRepository.logout).called(1);
//       },
//       timeout: const Timeout(
//         Duration(milliseconds: 500),
//       ),
//     );
//   });
// }
