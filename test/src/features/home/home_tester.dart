import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/features/home/presentation/home_gridview.dart';
import 'package:awesome_app/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import 'presentation/home_listview_test.dart';

class HomeTester {
  HomeTester(this.tester);
  final WidgetTester tester;

  Future<void> pumpApp(
      {required HomeScreenController controller,
      required CuratedPhotosRepository curatedPhotosRepository,
      required MockNavigatorObserver mockNavigatorObserver,
      bool settle = true}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          curatedPhotosRepositoryProvider
              .overrideWithValue(curatedPhotosRepository),
          homeScreenControllerProvider
              .overrideWithProvider(homeScreenControllerProvider),
          pageRequestProvider.overrideWithValue(StateController(1)),
        ],
        child: MaterialApp(
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
          navigatorObservers: [mockNavigatorObserver],
          home: const ListViewContentTest(),
        ),
      ),
      // const Duration(seconds: 5),
    );
    await tester.pump(const Duration(seconds: 5));
    curatedPhotosRepository.currentState;
    expect(find.byType(Card), findsOneWidget);
    await tester.tap(find.byType(Card));
    when(() => mockNavigatorObserver.didPush(any(), any()))
        .thenAnswer((invocation) {});
    // await tester.pump(const Duration(seconds: 5));
    // expect(find.byType(ListView), findsOneWidget);
  }

  Future<void> changeStyle() async {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
    // await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> likePhoto() async {
    final button = find.byKey(const Key("likedButton"));
    expect(button, findsWidgets);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Future<void> goToDetailPhoto() async {
    final detector = find.byType(GestureDetector);
    expect(detector, findsOneWidget);
    await tester.tap(detector);
    await tester.pumpAndSettle();
  }

  void expectChangeStyleListView() {
    final style = find.byWidget(const ListViewContentTest());
    expect(style, findsOneWidget);
  }

  void expectChangeStyleGridView() {
    final style = find.byWidget(const GridViewContent());
    expect(style, findsOneWidget);
  }

  void expectDetailScreen(MockNavigatorObserver observer) {
    observer.didPush(captureAny(), captureAny());
  }

  void expectImage() {
    final finder = find.byKey(const Key("imageLiked"));
    expect(finder, findsOneWidget);
  }
}
