import 'package:awesome_app/src/features/authentication/presentation/login_controller.dart';
import 'package:awesome_app/src/features/home/presentation/collapsible_appbar.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/features/home/presentation/home_error.dart';
import 'package:awesome_app/src/features/home/presentation/home_gridview.dart';
import 'package:awesome_app/src/features/home/presentation/home_listview.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_app/src/utils/async_value_ui.dart';
import 'package:nested_scroll_controller/nested_scroll_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  final NestedScrollController nestedScrollController =
      NestedScrollController();
  late AssetImage _image;
  late AssetImage _imageNotConnected;

  @override
  void initState() {
    _image = const AssetImage(AssetConstants.noImg);
    _imageNotConnected = const AssetImage(AssetConstants.notConnectedImg);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginScreenControllerProvider,
        (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(homeScreenControllerProvider);
    final listStyle = ref.watch(changeStyleProvider);
    return SafeArea(
        key: const Key("homeSafeArea"),
        child: state.when(
          data: (value) {
            return WillPopScope(
              onWillPop: () async {
                return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Quit ?"),
                          actions: [
                            TextButton(
                              child: const Text("No"),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () => Navigator.pop(context, true),
                            ),
                          ],
                        ));
              },
              child: Scaffold(
                key: const Key("dataScaffold"),
                backgroundColor: Colors.white,
                body: NestedScrollView(
                  controller: nestedScrollController,
                  headerSliverBuilder: ((context, innerBoxIsScrolled) {
                    return [
                      CollapsibleAppbar(image: _image),
                    ];
                  }),
                  body: LayoutBuilder(builder: (context, constraints) {
                    nestedScrollController.enableScroll(context);
                    nestedScrollController.enableCenterScroll(constraints);
                    nestedScrollController.innerScrollController
                        ?.addListener(() {
                      if (nestedScrollController
                              .innerScrollController!.position.pixels >=
                          nestedScrollController.innerScrollController!.position
                              .maxScrollExtent) {
                        // print("$isLoadMore absd");
                        int pageRequest =
                            ref.read(pageRequestProvider.state).state;
                        if (pageRequest < 80) {
                          print("$pageRequest request");
                          ref.read(pageRequestProvider.state).state += 1;
                        }
                      }
                    });
                    return listStyle
                        ? const ListViewContent()
                        : const GridViewContent();
                  }),
                ),
              ),
            );
          },
          error: (error, stackTrace) => HomeErrorView(
              error: error, imageNotConnected: _imageNotConnected),
          loading: () => Scaffold(
            key: const Key("loadingScaffold"),
            backgroundColor: Colors.white,
            body: NestedScrollView(
              controller: nestedScrollController,
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  CollapsibleAppbar(image: _image),
                ];
              }),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ));
  }
}
