import 'dart:io';

import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeErrorView extends ConsumerWidget {
  const HomeErrorView(
      {Key? key, required this.error, required this.imageNotConnected})
      : super(key: key);

  final Object error;
  final ImageProvider imageNotConnected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(AppConstants.paddingSize / 2),
        decoration:
            BoxDecoration(image: DecorationImage(image: imageNotConnected)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Text(
                error is SocketException || error is NoSuchMethodError
                    ? "Oops! Seems like you are not connected to the Internet"
                    : error.toString(),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(homeScreenControllerProvider.notifier)
                      .getCuratedPhotos();
                },
                child: const Text("Reload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
