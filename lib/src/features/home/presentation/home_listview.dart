import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:awesome_app/src/utils/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class ListViewContent extends ConsumerWidget {
  const ListViewContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenControllerProvider);
    final stateData = ref.watch(curatedPhotosStateChangesProvider).value;
    final pageRequest = ref.watch(pageRequestProvider);
    return stateData == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(AppConstants.paddingSize / 2,
                AppConstants.paddingSize / 2, AppConstants.paddingSize / 2, 0),
            itemCount: pageRequest,
            itemBuilder: ((context, index) {
              if (index < pageRequest - 1) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        key: const Key("photoDetail"),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.detailScreen,
                              arguments: stateData.photos![index]);
                        },
                        child: SizedBox(
                          height: AppConstants.getSize(context).height * 0.30,
                          width: AppConstants.getSize(context).width,
                          child: CachedNetworkImage(
                            imageUrl: stateData.photos![index].src!.portrait
                                .toString(),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.all(AppConstants.paddingSize / 3),
                        title: Text(
                          stateData.photos![index].photographer ?? "",
                          style: AppConstants.getTheme(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          stateData.photos![index].alt ?? "",
                          style: AppConstants.getTheme(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.grey),
                        ),
                        trailing: SizedBox(
                          height: 30,
                          width: 30,
                          child: LikeButton(
                            key: const Key('likedButton'),
                            isLiked: stateData.photos![index].liked ?? false,
                            onTap: (isLiked) async {
                              if (isLiked) {
                                stateData.photos![index].liked = false;
                                ref
                                    .read(
                                        likedPhotosControllerProvider.notifier)
                                    .remove(stateData.photos![index]);
                              } else {
                                stateData.photos![index].liked = true;
                                ref
                                    .read(
                                        likedPhotosControllerProvider.notifier)
                                    .add(stateData.photos![index]);
                              }
                              ref
                                  .read(homeScreenControllerProvider.notifier)
                                  .setCuratedPhotos(stateData);
                              return !isLiked;
                            },
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: pageRequest == 80
                      ? const SizedBox.shrink()
                      : const CircularProgressIndicator(),
                );
              }
            }),
          );
  }
}
