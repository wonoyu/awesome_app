import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_app/src/utils/async_value_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(homeScreenControllerProvider,
        (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(homeScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              ref.read(homeScreenControllerProvider.notifier).logout();
            },
          )
        ],
      ),
    );
  }
}
