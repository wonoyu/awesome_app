import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockHomeRepository homeRepository;
  late MockLikedPhotosRepository likedPhotosRepository;
  late HomeScreenController controller;
  late LikedPhotosController likedPhotosController;
  late MockCuratedPhotos curatedPhotos;
  late MockPhotos photo;

  setUp(() {
    homeRepository = MockHomeRepository();
    curatedPhotos = MockCuratedPhotos();
    likedPhotosRepository = MockLikedPhotosRepository();
    photo = MockPhotos();
    controller = HomeScreenController(curatedPhotosRepository: homeRepository);
    likedPhotosController =
        LikedPhotosController(likedPhotosRepository: likedPhotosRepository);
  });

  group('HomeScreenController', () {
    test('initial state is AsyncData', () {
      verifyNever(() => homeRepository.setCuratedPhotos(curatedPhotos));
      expect(controller.debugState, const AsyncData<void>(null));
    });

    test(
      'get data success',
      () async {
        // setup
        when(homeRepository.getCuratedPhotos).thenAnswer((_) => Future.value());
        // run
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              const AsyncData<void>(null),
            ]));
        await controller.getCuratedPhotos();
        // verify
        verify(homeRepository.getCuratedPhotos).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'get data failure',
      () async {
        // setup
        final exception = Exception('Connection failed');
        when(homeRepository.getCuratedPhotos).thenThrow(exception);
        // run
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              predicate<AsyncValue<void>>((value) {
                expect(value, isA<AsyncError<void>>());
                return true;
              }),
            ]));
        await controller.getCuratedPhotos();
        // verify
        verify(homeRepository.getCuratedPhotos).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'add liked photo success',
      () async {
        // setup
        when(() => likedPhotosRepository.add(photo))
            .thenAnswer((_) => Future.value());
        // run
        expectLater(
            likedPhotosController.stream,
            emitsInOrder([
              const AsyncData<void>(null),
            ]));
        await likedPhotosController.add(photo);
        // verify
        verify(() => likedPhotosRepository.add(photo)).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'add liked photo failure',
      () async {
        // setup
        final exception = Exception('Failed to add liked photo');
        when(() => likedPhotosRepository.add(photo)).thenThrow(exception);
        // run
        expectLater(
            likedPhotosController.stream,
            emitsInOrder([
              predicate<AsyncValue<void>>((value) {
                expect(value, isA<AsyncError<void>>());
                return true;
              }),
            ]));
        await likedPhotosController.add(photo);
        // verify
        verify(() => likedPhotosController.add(photo)).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 3000),
      ),
    );

    test(
      'remove liked photo success',
      () async {
        // setup
        when(() => likedPhotosRepository.remove(photo))
            .thenAnswer((_) => Future.value());
        // run
        expectLater(
            likedPhotosController.stream,
            emitsInOrder([
              const AsyncData<void>(null),
            ]));
        await likedPhotosController.remove(photo);
        // verify
        verify(() => likedPhotosRepository.remove(photo)).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 500),
      ),
    );

    test(
      'remove liked photo failure',
      () async {
        // setup
        final exception = Exception('Failed to remove liked photo');
        when(() => likedPhotosRepository.remove(photo)).thenThrow(exception);
        // run
        expectLater(
            likedPhotosController.stream,
            emitsInOrder([
              predicate<AsyncValue<void>>((value) {
                expect(value, isA<AsyncError<void>>());
                return true;
              }),
            ]));
        await likedPhotosController.remove(photo);
        // verify
        verify(() => likedPhotosController.remove(photo)).called(1);
      },
      timeout: const Timeout(
        Duration(milliseconds: 3000),
      ),
    );
  });
}
