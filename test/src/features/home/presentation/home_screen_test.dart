import 'package:awesome_app/src/features/home/data/home_repository_test.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../home_tester.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
        MaterialPageRoute(builder: (_) => const SizedBox.shrink()));
  });
  group('HomeScreen', () {
    late FakeCuratedPhotosRepository homeRepository;
    late MockNavigatorObserver mockNavigatorObserver;
    late HomeScreenController homeScreenController;

    setUp(() {
      homeRepository = FakeCuratedPhotosRepository();
      mockNavigatorObserver = MockNavigatorObserver();
      homeScreenController =
          HomeScreenController(curatedPhotosRepository: homeRepository);
    });
    testWidgets('list view content', (tester) async {
      final homeTester = HomeTester(tester);
      await homeTester.pumpApp(
          controller: homeScreenController,
          curatedPhotosRepository: homeRepository,
          mockNavigatorObserver: mockNavigatorObserver);
      // await homeTester.changeStyle(homeScreenController, homeRepository);
      // homeTester.expectChangeStyleGridView();
      // await homeTester.changeStyle(homeScreenController, homeRepository);
      // homeTester.expectChangeStyleListView();
      // await homeTester.goToDetailPhoto();
      // homeTester.expectDetailScreen(mockNavigatorObserver);
      // await homeTester.likePhoto();
      // homeTester.expectImage();
    });
  });
}
