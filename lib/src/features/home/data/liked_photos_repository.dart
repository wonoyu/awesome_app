import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/utils/temporary_data_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedPhotosRepository {
  final _state = TemporaryStorage<List<Photo>>([]);

  Stream<List<Photo>> stateChanges() => _state.stream;
  List<Photo> get currentState => _state.value;

  Future<void> add(Photo photo) async {
    _state.value = List.from(_state.value..add(photo));
  }

  Future<void> remove(Photo photo) async {
    _state.value = List.from(_state.value..remove(photo));
  }

  void dispose() => _state.dispose();
}

final likedPhotosRepositoryProvider = Provider<LikedPhotosRepository>((ref) {
  final curatedPhotosRepository = LikedPhotosRepository();
  ref.onDispose(() => curatedPhotosRepository.dispose());
  return curatedPhotosRepository;
});

final likedPhotosStateChangesProvider =
    StreamProvider.autoDispose<List<Photo>>((ref) {
  final likedPhotosRepository = ref.watch(likedPhotosRepositoryProvider);
  return likedPhotosRepository.stateChanges();
});
