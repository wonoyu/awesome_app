import 'package:awesome_app/src/app.dart';
import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/presentation/collapsible_appbar.dart';
import 'package:awesome_app/src/features/home/presentation/home_gridview.dart';
import 'package:awesome_app/src/features/home/presentation/home_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeTester {
  HomeTester(this.tester);
  final WidgetTester tester;

  Future<void> pumpApp(
      {CuratedPhotosRepository? curatedPhotosRepository,
      bool settle = true}) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [
        if (curatedPhotosRepository != null)
          curatedPhotosRepositoryProvider
              .overrideWithValue(curatedPhotosRepository)
      ], child: const AwesomeApp()),
    );
    if (settle) await tester.pumpAndSettle();
  }

  Future<void> changeStyle() async {
    find.widgetWithIcon(ConsumerWidget, Icons.photo_library_outlined);
    final collapsible =
        find.byWidget(const CollapsibleAppbar(image: AssetImage("")));
    final button = find.byWidget(
        AppbarActions(icon: Icons.photo_library_outlined, onTap: () async {}));
    expect(collapsible, findsOneWidget);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Future<void> likePhoto() async {
    final button = find.byKey(const Key("likedButton"));
    expect(button, findsWidgets);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  Future<void> goToDetailPhoto() async {
    final detector = find.byKey(const Key("photoDetail"));
    expect(detector, findsWidgets);
    await tester.tap(detector);
    await tester.pumpAndSettle();
  }

  void expectChangeStyleListView() {
    final style = find.byWidget(const ListViewContent());
    expect(style, findsOneWidget);
  }

  void expectChangeStyleGridView() {
    final style = find.byWidget(const GridViewContent());
    expect(style, findsOneWidget);
  }

  void expectDetailScreen() {
    final detector = find.byKey(const Key("source"));
    expect(detector, findsOneWidget);
  }

  void expectImage() {
    final finder = find.byKey(const Key("imageLiked"));
    expect(finder, findsOneWidget);
  }
}
