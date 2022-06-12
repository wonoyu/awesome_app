import 'package:awesome_app/src/features/authentication/presentation/login_controller.dart';
import 'package:awesome_app/src/features/home/data/liked_photos_repository.dart';
import 'package:awesome_app/src/features/home/presentation/home_controller.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollapsibleAppbar extends ConsumerWidget {
  const CollapsibleAppbar({Key? key, required this.image}) : super(key: key);

  final AssetImage image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateLikedPhotos = ref.watch(likedPhotosStateChangesProvider).value;
    final listStyle = ref.watch(changeStyleProvider);
    return SliverAppBar(
      key: const Key("collapsibleAppbar"),
      primary: false,
      title: const Text("Discover"),
      elevation: 0.0,
      backgroundColor: Colors.white,
      actions: [
        AppbarActions(
            key: const Key("changeStyleKey"),
            icon: Icons.photo_library_outlined,
            onTap: () async {
              ref.read(changeStyleProvider.state).state = !listStyle;
            }),
        AppbarActions(
            icon: Icons.logout_outlined,
            onTap: () async {
              ref.read(loginScreenControllerProvider.notifier).logout();
            }),
      ],
      expandedHeight: AppConstants.getSize(context).height * 0.30,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView.useDelegate(
              key: const Key("imageLiked"),
              useMagnifier: true,
              physics: const FixedExtentScrollPhysics(),
              itemExtent: AppConstants.getSize(context).width,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: stateLikedPhotos == null || stateLikedPhotos.isEmpty
                    ? 1
                    : stateLikedPhotos.length,
                builder: (context, index) {
                  if (stateLikedPhotos == null || stateLikedPhotos.isEmpty) {
                    return CollapsibleAppbarContent(
                        photographer:
                            "No liked images yet, hit the heart to like some!",
                        src: image);
                  }
                  return CollapsibleAppbarContent(
                    src: CachedNetworkImageProvider(
                        stateLikedPhotos[index].src!.landscape.toString()),
                    photographer:
                        "Photo by : ${stateLikedPhotos[index].photographer!}",
                  );
                },
              )),
        ),
      ),
    );
  }
}

class AppbarActions extends ConsumerWidget {
  const AppbarActions({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  final IconData icon;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingSize / 4),
        margin: const EdgeInsets.only(
            bottom: AppConstants.paddingSize / 3,
            right: AppConstants.paddingSize / 3,
            top: AppConstants.paddingSize / 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black.withOpacity(0.4),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CollapsibleAppbarContent extends ConsumerWidget {
  const CollapsibleAppbarContent(
      {Key? key, required this.photographer, required this.src})
      : super(key: key);

  final String photographer;
  final ImageProvider src;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: src,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            alignment: Alignment.center,
            width: AppConstants.getSize(context).width,
            height: 50,
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
                ])),
            child: Text(
              photographer,
              textAlign: TextAlign.center,
              style: AppConstants.getTheme(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
