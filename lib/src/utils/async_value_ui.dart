import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackbarOnError(BuildContext context) {
    whenOrNull(
      loading: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            margin: const EdgeInsets.all(AppConstants.paddingSize / 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator.adaptive(),
                SizedBox(
                  width: AppConstants.paddingSize,
                ),
                Text('Loading...'),
              ],
            ),
          ),
        ),
      ),
      data: (data) => Navigator.of(context, rootNavigator: true).pop(),
      error: ((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          )),
    );
  }
}
