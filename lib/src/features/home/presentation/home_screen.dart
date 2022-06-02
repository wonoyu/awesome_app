import 'package:awesome_app/src/features/authentication/presentation/login_controller.dart';
import 'package:awesome_app/src/features/home/data/home_repository.dart';
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
    nestedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginScreenControllerProvider,
        (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(homeScreenControllerProvider);
    final stateData = ref.watch(curatedPhotosStateChangesProvider).value;
    final listStyle = ref.watch(changeStyleProvider);
    return SafeArea(
        child: state.when(
      data: (value) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (stateData == null) {
            ref.read(homeScreenControllerProvider.notifier).getCuratedPhotos();
          }
        });
        return stateData == null
            ? const Center(child: CircularProgressIndicator())
            : WillPopScope(
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
                  backgroundColor: Colors.white,
                  body: NestedScrollView(
                    // key: globalKey,
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
                            nestedScrollController.innerScrollController!
                                .position.maxScrollExtent) {
                          int page = ref.read(pageRequestProvider.state).state;
                          if (page < 80) {
                            ref.read(pageRequestProvider.state).state += 10;
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
      error: (error, stackTrace) =>
          HomeErrorView(error: error, imageNotConnected: _imageNotConnected),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ));
  }
}
