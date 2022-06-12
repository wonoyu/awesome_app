import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:awesome_app/src/utils/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class GridViewContent extends ConsumerStatefulWidget {
  const GridViewContent({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GridViewContentState();
}

class _GridViewContentState extends ConsumerState<GridViewContent> {
  @override
  Widget build(BuildContext context) {
    final stateData = ref.watch(curatedPhotosStateChangesProvider).value;
    final itemPerPage = ref.watch(pageRequestProvider);
    return GridView.builder(
        // controller: widget.controller,
        padding: const EdgeInsets.all(AppConstants.paddingSize / 3),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2.0,
            crossAxisSpacing: AppConstants.paddingSize / 4,
            mainAxisSpacing: AppConstants.paddingSize / 3),
        itemCount: itemPerPage,
        itemBuilder: (context, index) => GestureDetector(
              key: const Key("photoDetail"),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.detailScreen,
                    arguments: stateData!.photos![index]);
              },
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        stateData!.photos![index].src!.portrait.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: AppConstants.paddingSize / 3),
                      alignment: Alignment.bottomCenter,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [
                              0.0,
                              1.0
                            ],
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.1)
                            ]),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: Center(
                          child: LikeButton(
                              key: const Key('likedButton'),
                              size: 30,
                              isLiked: stateData.photos![index].liked ?? false,
                              onTap: (isLiked) async {
                                if (isLiked) {
                                  stateData.photos![index].liked = false;
                                  ref
                                      .read(likedPhotosControllerProvider
                                          .notifier)
                                      .remove(stateData.photos![index]);
                                } else {
                                  stateData.photos![index].liked = true;
                                  ref
                                      .read(likedPhotosControllerProvider
                                          .notifier)
                                      .add(stateData.photos![index]);
                                }
                                ref
                                    .read(homeScreenControllerProvider.notifier)
                                    .setCuratedPhotos(stateData);
                                return !isLiked;
                              }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
