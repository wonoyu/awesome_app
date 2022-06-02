import 'package:flutter_test/flutter_test.dart';

import '../home_tester.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('tap gesture detector and buttons', (tester) async {
      final homeTester = HomeTester(tester);
      await homeTester.pumpApp();
      await homeTester.changeStyle();
      homeTester.expectChangeStyleGridView();
      await homeTester.changeStyle();
      homeTester.expectChangeStyleListView();
      await homeTester.goToDetailPhoto();
      homeTester.expectDetailScreen();
      await homeTester.likePhoto();
      homeTester.expectImage();
    });
  });
}
