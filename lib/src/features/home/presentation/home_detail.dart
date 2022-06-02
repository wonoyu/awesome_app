import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeDetail extends ConsumerWidget {
  const HomeDetail({Key? key, required this.photo}) : super(key: key);

  final Photo? photo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(photo!.src!.portrait!))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: AppConstants.paddingSize * 2,
                        left: AppConstants.paddingSize * 2,
                        right: AppConstants.paddingSize / 2),
                    width: AppConstants.getSize(context).width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [
                          0.0,
                          1.0
                        ],
                            colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.1)
                        ])),
                    height: AppConstants.getSize(context).height * 0.30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: AppConstants.paddingSize,
                        ),
                        Text(
                          "Photo By : ${photo!.photographer}",
                          style: AppConstants.getTheme(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: AppConstants.paddingSize / 2,
                        ),
                        Text(
                          photo!.alt!,
                          style: AppConstants.getTheme(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: AppConstants.paddingSize / 2,
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.only(
                      left: AppConstants.paddingSize / 2,
                      right: AppConstants.paddingSize / 2),
                  width: AppConstants.getSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                        0.0,
                        1.0
                      ],
                          colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.1)
                      ])),
                  height: AppConstants.getSize(context).height * 0.10,
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunchUrlString(photo!.src!.portrait!)) {
                        await launchUrlString(photo!.src!.portrait!,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Wrap(
                      spacing: AppConstants.paddingSize / 2,
                      runSpacing: AppConstants.paddingSize / 2,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              AppConstants.paddingSize / 3),
                          child: Text(
                            "Source : ${photo!.src!.portrait!}",
                            style: AppConstants.getTheme(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
