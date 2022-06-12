import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/data/liked_photos_repository.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenController extends StateNotifier<AsyncValue<void>> {
  HomeScreenController({
    required this.curatedPhotosRepository,
  }) : super(const AsyncData<void>(null));
  final CuratedPhotosRepository curatedPhotosRepository;

  void init() {
    if (curatedPhotosRepository.currentState == null) {
      getCuratedPhotos();
    }
  }

  Future<void> getCuratedPhotos() async {
    print(curatedPhotosRepository.currentState);
    state = const AsyncLoading();
    state = await AsyncValue.guard(curatedPhotosRepository.getCuratedPhotos);
  }

  Future<void> setCuratedPhotos(CuratedPhotos curatedPhotos) async {
    curatedPhotosRepository.setCuratedPhotos(curatedPhotos);
  }
}

// class LoadMoreController extends StateNotifier<AsyncValue<void>> {
//   LoadMoreController({
//     required this.curatedPhotosRepository,
//   }) : super(const AsyncData<void>(null));
//   final CuratedPhotosRepository curatedPhotosRepository;

//   Future<void> loadMoreCuratedPhotos(int pages) async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(
//       () => curatedPhotosRepository.loadMoreCuratedPhotos(pages),
//     );
//   }
// }

class LikedPhotosController extends StateNotifier<AsyncValue<void>> {
  LikedPhotosController({required this.likedPhotosRepository})
      : super(const AsyncData(null));
  final LikedPhotosRepository likedPhotosRepository;

  Future<void> add(Photo photo) async {
    state = await AsyncValue.guard(() => likedPhotosRepository.add(photo));
  }

  Future<void> remove(Photo photo) async {
    state = await AsyncValue.guard(() => likedPhotosRepository.remove(photo));
  }
}

final likedPhotosControllerProvider =
    StateNotifierProvider.autoDispose<LikedPhotosController, AsyncValue<void>>(
        (ref) {
  final likedPhotosRepository = ref.watch(likedPhotosRepositoryProvider);
  return LikedPhotosController(likedPhotosRepository: likedPhotosRepository);
});

// final loadMoreControllerProvider =
//     StateNotifierProvider.autoDispose<LoadMoreController, AsyncValue<void>>(
//         (ref) {
//   final curatedPhotosRepository = ref.watch(curatedPhotosRepositoryProvider);
//   return LoadMoreController(curatedPhotosRepository: curatedPhotosRepository);
// });

final homeScreenControllerProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, AsyncValue<void>>(
        (ref) {
  final curatedPhotosRepository = ref.watch(curatedPhotosRepositoryProvider);
  return HomeScreenController(
    curatedPhotosRepository: curatedPhotosRepository,
  )..init();
});

final pageRequestProvider = StateProvider<int>((ref) {
  return 10;
});

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final changeStyleProvider = StateProvider<bool>((ref) {
  return true;
});

final scrollToTopProvider = StateProvider<bool>((ref) {
  return false;
});
