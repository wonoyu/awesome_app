import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/data/liked_photos_repository.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/utils/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenController extends StateNotifier<AsyncValue<void>> {
  HomeScreenController({
    required this.curatedPhotosRepository,
    required this.sharedPreferencesProvider,
  }) : super(const AsyncData(null)) {
    getCuratedPhotos();
  }
  final CuratedPhotosRepository curatedPhotosRepository;
  final SharedPreferencesProvider sharedPreferencesProvider;

  Future<void> getCuratedPhotos() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => curatedPhotosRepository.getCuratedPhotos());
  }

  Future<void> setCuratedPhotos(CuratedPhotos curatedPhotos) async {
    curatedPhotosRepository.setCuratedPhotos(curatedPhotos);
  }
}

class LikedPhotosController extends StateNotifier<AsyncValue<void>> {
  LikedPhotosController(this.likedPhotosRepository)
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
  return LikedPhotosController(likedPhotosRepository);
});

final homeScreenControllerProvider =
    StateNotifierProvider<HomeScreenController, AsyncValue<void>>((ref) {
  final curatedPhotosRepository = ref.watch(curatedPhotosRepositoryProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return HomeScreenController(
      curatedPhotosRepository: curatedPhotosRepository,
      sharedPreferencesProvider: sharedPreferences);
});

final pageRequestProvider = StateProvider<int>((ref) {
  return 10;
});

final changeStyleProvider = StateProvider<bool>((ref) {
  return true;
});

final scrollToTopProvider = StateProvider<bool>((ref) {
  return false;
});
